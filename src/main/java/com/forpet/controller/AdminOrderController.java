package com.forpet.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.forpet.domain.OrderVO;
import com.forpet.dto.Criteria;
import com.forpet.dto.PageDTO;
import com.forpet.service.AdminOrderService;
import com.forpet.util.UploadFileUtils;

import lombok.Setter;


@RequestMapping("/admin/order/*")
@Controller
public class AdminOrderController {

	@Resource(name = "uploadPath") 
	private String uploadPath;	
	
	@Setter(onMethod_ = {@Autowired})
	private AdminOrderService adminOrderService;
	
	/* ----------
	        주문 목록 
	 ------------ */
	@GetMapping("/orderList")
	public void orderList(@RequestParam(value = "startDate", required = false) String startDate, 
						  @RequestParam(value = "endDate", required = false) String endDate,
						  Criteria cri, Model model) {
		
		cri.setAmount(5);
		
		// 페이징쿼리에 의한 주문목록
		List<OrderVO> orderList = adminOrderService.getOrderList(startDate, endDate, cri);
		model.addAttribute("orderList", orderList);
		
		// 페이지 개수
		int totalCount = adminOrderService.getOrderTotalCount(startDate, endDate, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
	}
	
	/* ----------------
	       주문 배송상태 변경 
	 ------------------ */
	@ResponseBody
	@GetMapping("/orderStatusChange")
	public ResponseEntity<String> orderStatusChange(Long odr_number, String odr_status) {
		
		ResponseEntity<String> entity = null;
		
		adminOrderService.orderStatusChange(odr_number, odr_status);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;		
	}
	
	/* --------------------------
	        체크박스로 선택한 주문정보 삭제 
	 ---------------------------- */
	@ResponseBody
	@PostMapping("/orderCheckedDelete")
	public ResponseEntity<String> orderCheckedDelete(@RequestParam("odrNumberArr[]") List<Long> odrNumberArr) {
		
		ResponseEntity<String> entity = null;
		
		for(int i=0; i<odrNumberArr.size(); i++) {
			
			adminOrderService.orderDelete(odrNumberArr.get(i));
		}
		
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;	
	}
	
	/* -------------
	       주문상세 내역 
	 --------------- */
	@GetMapping("/orderDetail")
	public void orderDetail(Long odr_number, Model model) {
			
		// 주문정보
		model.addAttribute("orderVO", adminOrderService.getOrderInfo(odr_number));
		
		// 결제정보
		model.addAttribute("paymentVO", adminOrderService.getPaymentInfo(odr_number));
		
		// 주문 상품정보
		List<Map<String, Object>> orderProductListMap = adminOrderService.getOrderProductInfo(odr_number);
		
		// 날짜 폴더명의 \(역슬래시)를 /로 변환
		for(int i=0; i<orderProductListMap.size(); i++) {
			Map<String, Object> orderProduct = orderProductListMap.get(i);
			
			String img_folder = String.valueOf(orderProduct.get("PDT_IMG_FOLDER")).replace("\\", "/");
			orderProduct.put("PDT_IMG_FOLDER", img_folder);
		}
		
		model.addAttribute("orderProductMap", orderProductListMap);
		
	}
	
	/* ---------------------------
	       주문상세 내역에서 이미지 보여주기
	 ----------------------------- */
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName) {	
				
		// 이미지를 바이트 배열로 읽어오는 작업
		return UploadFileUtils.getFile(uploadPath, folderName + "\\" +fileName);
	}
	
	
	/* ----------------
	       주문상품 개별 취소 
	 ------------------ */
	@GetMapping("/orderUnitProductCancel")
	public String orderUnitProductCancel(Long odr_number, Integer pdt_number, int odr_price, RedirectAttributes rttr) {
		
		adminOrderService.orderUnitProductCancel(odr_number, pdt_number, odr_price);
			
		rttr.addAttribute("odr_number", odr_number);
		
		return "redirect:/admin/order/orderDetail";
	}
	
	/* -------------
	        주문변경 목록 
	 --------------- */
	@GetMapping("/orderChangeList")
	public void orderChangeList(@RequestParam(value = "startDate", required = false) String startDate, 
								@RequestParam(value = "endDate", required = false) String endDate,
								Criteria cri, Model model) {
		
		// 페이징쿼리에 의한 주문변경 목록
		List<OrderVO> orderChangeList = adminOrderService.getOrderChangeList(startDate, endDate, cri);
		model.addAttribute("orderChangeList", orderChangeList);
		
		// 페이지 개수
		int totalCount = adminOrderService.getOrderChangeTotalCount(startDate, endDate, cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
	}
}
