package com.forpet.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.forpet.domain.CartVO;
import com.forpet.domain.CartVOList;
import com.forpet.domain.MemberVO;
import com.forpet.service.CartService;
import com.forpet.util.UploadFileUtils;

import lombok.Setter;

@RequestMapping("/user/cart/*")
@Controller
public class CartController {
	
	@Resource(name = "uploadPath") 
	private String uploadPath;
	
	@Setter(onMethod_ = {@Autowired})
	private CartService cartService;
	
	/* ----------------- 
	       장바구니에 상품 추가 
	 ------------------- */
	@ResponseBody
	@GetMapping("/cart_add")
	public ResponseEntity<String> cart_add(CartVO vo, HttpSession session) {
		
		ResponseEntity<String> entity = null;
				
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		vo.setMem_id(mem_id);
		
		cartService.cart_add(vo);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	/* -------------
	       장바구니 목록 
	 --------------- */
	@GetMapping("/cart_list")
	public String cart_list(HttpSession session, Model model) {
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		List<CartVOList> vo = cartService.cart_list(mem_id);
		
		// 날짜 폴더명의 \(역슬래시)를 /로 변환
		for(int i=0; i<vo.size(); i++) {
			String pdt_img_foler = vo.get(i).getPdt_img_folder().replace("\\", "/"); 
			vo.get(i).setPdt_img_folder(pdt_img_foler);
		}
		
		model.addAttribute("cartList", vo);
		
		return "/user/cart/cartList";
	}
	
	/* ---------------------------
	        장바구니 목록에서 이미지 보여주기
	 ----------------------------- */
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String folderName, String fileName) {
			
		// 이미지를 바이트 배열로 읽어오는 작업
		return UploadFileUtils.getFile(uploadPath, folderName + "\\" +fileName);
	}
	
	/* -----------------
	        장바구니 수량 변경 
	  ------------------ */
	@GetMapping("/cart_amount_update")
	public String cart_amount_update(@RequestParam("crt_code") Long crt_code,  @RequestParam("pdt_buy_amount") int pdt_buy_amount) {
		
		cartService.cart_amount_update(crt_code, pdt_buy_amount);
		
		return "redirect:/user/cart/cart_list";
	}
	
	/* -----------------
	        장바구니 상품 삭제 
	 ------------------- */
	@GetMapping("/cart_delete")
	public String cart_delete(@RequestParam("crt_code") Long crt_code) {
		
		cartService.cart_delete(crt_code);
		
		return "redirect:/user/cart/cart_list";
	}
	
	/* ---------------------------
	        장바구니 비우기  : 상품 전체삭제 
	  ---------------------------- */
	@GetMapping("/cart_empty")
	public String cart_empty(HttpSession session) {
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		cartService.cart_empty(mem_id);
		
		return "redirect:/user/cart/cart_list";
	}
}
