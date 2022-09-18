package com.forpet.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.forpet.domain.CartOrderInfo;
import com.forpet.domain.CartVO;
import com.forpet.domain.CartVOList;
import com.forpet.domain.MemberVO;
import com.forpet.domain.OrderVO;
import com.forpet.domain.PaymentVO;
import com.forpet.dto.Criteria;
import com.forpet.dto.PageDTO;
import com.forpet.kakaopay.ApproveResponse;
import com.forpet.kakaopay.ReadyResponse;
import com.forpet.service.CartService;
import com.forpet.service.KakaoPayServiceImpl;
import com.forpet.service.OrderService;
import com.forpet.util.UploadFileUtils;

import lombok.Setter;

@RequestMapping("/user/order/*")
@Controller
public class OrderController {

	@Resource(name = "uploadPath") 
	private String uploadPath;
	
	@Setter(onMethod_ = {@Autowired})
	private OrderService orderService;
	
	@Setter(onMethod_ = {@Autowired})
	private CartService cartService;
	
	@Setter(onMethod_ = {@Autowired})
	private KakaoPayServiceImpl kakaoPayServiceImpl;
	
	
	/* -------------
	        주문 결제 목록 
	  -------------- */
	@GetMapping("/orderListInfo")
	public void orderListInfo(@RequestParam("type") String type, Integer pdt_number, Integer odr_amount,
							   HttpSession session, Model model) {
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		List<CartOrderInfo> orderInfoList = null;
		
		if(type.equals("cartOrder")) { // 1)장바구니에서 주문하기.
			orderInfoList = orderService.cartOrderList(mem_id);
			
		}else if(type.equals("directOrder")) { // 2) 상품목록 모달대화상자 - 구매하기.
			orderInfoList = orderService.directOrderList(pdt_number, odr_amount);
			
			// 직접구매시 장바구니에 데이터 저장			
			CartVO vo = new CartVO(); 
			vo.setMem_id(mem_id);
			vo.setPdt_number(pdt_number);
			vo.setPdt_buy_amount(odr_amount);
			
			cartService.cart_add(vo);
			
		}
		
		// // 날짜 폴더명의 \(역슬래시)를 /로 변환.
		for(int i=0; i<orderInfoList.size(); i++) {
			String pdt_img_foler = orderInfoList.get(i).getPdt_img_folder().replace("\\", "/"); 
			orderInfoList.get(i).setPdt_img_folder(pdt_img_foler);
		}
		
		model.addAttribute("cartOrderList", orderInfoList);
		

	}
	
	/* ---------------------------
	       주문결제 목록에서 이미지 보여주기
	 ----------------------------- */
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName) {
				
		// 이미지를 바이트 배열로 읽어오는 작업
		return UploadFileUtils.getFile(uploadPath, folderName + "\\" +fileName);
	}
	
	/* ----------------
	       주문결제 정보 저장
	 ------------------ */
	@PostMapping("/orderSave")
	public String orderSave(OrderVO o_vo, PaymentVO p_vo, String type, HttpSession session) {
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		o_vo.setMem_id(mem_id);
		
		// 무통장 입금일 경우
		if(type.equals("무통장입금")) {
			
			o_vo.setPay_status("입금전");
			
			p_vo.setPay_total_price(o_vo.getOdr_total_price());  // 총 결제금액
			p_vo.setPay_rest_price(0);							 // 추가 입금액
		}
		
		orderService.orderBuy(o_vo, p_vo);
			
		return "redirect:/user/order/orderComplete";	
	}
	
	/* ------------------
	        카카오페이 결제 요청 
	 -------------------- */
	@GetMapping("/orderPay")
	public @ResponseBody ReadyResponse payReady(OrderVO o_vo, PaymentVO p_vo, int totalAmount, 
												HttpSession session, Model model) {
		
		// 장바구니테이블 상품정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		// 장바구니에서 주문이 진행될 때
		List<CartVOList> cartList = cartService.cart_list(mem_id);
		String itemName = cartList.get(0).getPdt_name() + "외 " + String.valueOf(cartList.size() - 1) + " 개";
		int quantity = cartList.size() - 1;
				
		// 카카오페이서버에서 보낸온 정보. 1차 준비요청 => QR코드 주소 리턴
		ReadyResponse readyResponse = kakaoPayServiceImpl.payReady(itemName, quantity, mem_id, totalAmount);
				
		session.setAttribute("tid", readyResponse.getTid());
		o_vo.setMem_id(mem_id);
		session.setAttribute("order", o_vo);
		session.setAttribute("payment", p_vo);
		
			
		return readyResponse;
	}
	
	/* --------------------------
	       카카오페이 QR코드 결제승인 요청
	 ---------------------------- */
	// 카카오페이 서버에서 결제가 성공적으로 끝나면 카카오페이 서버에서 호출하는 주소
	@GetMapping("/orderApproval")
	public String orderApproval(@RequestParam("pg_token") String pgToken, HttpSession session ) {
		
		
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		String tid = (String) session.getAttribute("tid");
		OrderVO o_vo = (OrderVO) session.getAttribute("order"); 
		PaymentVO p_vo = (PaymentVO )session.getAttribute("payment");
		
		// 세션 제거 
		session.removeAttribute("tid"); 
		session.removeAttribute("order");
		session.removeAttribute("payment");
		
		
		// 카카오페이 결제. 2번째 요청
		ApproveResponse approveResponse = kakaoPayServiceImpl.payApprove(tid, pgToken, mem_id);
		
		// 카카오페이 결제정보 DB저장 
		orderService.orderBuy(o_vo, p_vo);

		return "redirect:/user/order/orderComplete";
	}
	
	/* ------------
	       결제완료 내역 
	 -------------- */
	@GetMapping("/orderComplete")
	public void orderComplete(HttpSession session, Model model) {
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		model.addAttribute("orderVO", orderService.orderComplete(mem_id));
	}
	
	/* -------------
	       주문내역 조회
	 --------------- */
	@GetMapping("/orderDetailList")
	public void orderDetail(@RequestParam(value = "startDate", required = false) String startDate, 
							@RequestParam(value = "endDate", required = false) String endDate,
							Criteria cri, Model model, HttpSession session) {
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
					
		// 주문 상품정보
		List<Map<String, Object>> orderProductListMap  = orderService.getOrderProductInfo(mem_id, startDate, endDate, cri);
		
		// // 날짜 폴더명의 \(역슬래시)를 /로 변환.
		for(int i=0; i<orderProductListMap.size(); i++) {
			Map<String, Object> orderProduct = orderProductListMap.get(i);
			
			String img_folder = String.valueOf(orderProduct.get("PDT_IMG_FOLDER")).replace("\\", "/");
			orderProduct.put("PDT_IMG_FOLDER", img_folder);
		}
		
		model.addAttribute("orderProductMap", orderProductListMap);
		
		int totalCount = orderService.getTotalCount(mem_id, startDate, endDate, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		
	}
	
}
