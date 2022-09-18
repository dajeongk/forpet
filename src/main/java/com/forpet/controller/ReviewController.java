package com.forpet.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.forpet.domain.MemberVO;
import com.forpet.domain.ReviewVO;
import com.forpet.dto.Criteria;
import com.forpet.dto.PageDTO;
import com.forpet.service.ReviewService;

import lombok.Setter;

@RequestMapping("/user/review/*")
@RestController
public class ReviewController {

	@Setter(onMethod_ = {@Autowired})
	private ReviewService reviewService;
	
	/* ------------
	       상품후기 작성 
	 -------------- */
	@ResponseBody
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReviewVO vo, HttpSession session) {
				
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		vo.setMem_id(mem_id);
		
		ResponseEntity<String> entity = null;				
		
		entity = new ResponseEntity<String>(String.valueOf(reviewService.create(vo)), HttpStatus.OK);
		
		return entity;
						    
	}
	
	/* ------------
	       상품후기 목록
	 -------------- */
	@ResponseBody
	@GetMapping(value = "/list/{pdt_number}/{page}")
	public ResponseEntity<Map<String, Object>> reviewList(@PathVariable("pdt_number") Integer pdt_number, @PathVariable("page") Integer page) {
		
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 검색필드를 사용하지 않으므로, 메서드의 파라미터로 사용하지 않고 객체를 직접 생성함.
		Criteria cri = new Criteria();
		cri.setPageNum(page);
		cri.setAmount(5);
		
		// 리뷰 목록
		List<ReviewVO> list = reviewService.list(pdt_number, cri);
		map.put("list", list);
		
		// 페이징정보
		PageDTO pageMaker = new PageDTO(cri, reviewService.listCount(pdt_number));
		map.put("pageMaker", pageMaker);
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		return entity;
	}
	
	/* ------------
	       상품후기 수정 
	 -------------- */
	@ResponseBody
	@PatchMapping(value = "/modify", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReviewVO vo, HttpSession session) {
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		vo.setMem_id(mem_id);
		
		ResponseEntity<String> entity = null;
		
		reviewService.modify(vo);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
	}
	
	/* -------------
	       상품후기 삭제 
	 --------------- */
	@ResponseBody
	@DeleteMapping(value = "/delete/{rvw_number}", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> delete(@PathVariable("rvw_number") Integer rvw_number, @RequestBody ReviewVO vo,
										 HttpSession session) {
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		vo.setMem_id(mem_id);
		
		ResponseEntity<String> entity = null;
		
		entity = new ResponseEntity<String>(String.valueOf(reviewService.delete(rvw_number)), HttpStatus.OK);
		
		return entity;
	}
}
