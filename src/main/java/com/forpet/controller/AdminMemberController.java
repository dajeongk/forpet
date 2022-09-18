package com.forpet.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.forpet.domain.MemberVO;
import com.forpet.dto.Criteria;
import com.forpet.dto.PageDTO;
import com.forpet.service.AdminMemberService;

import lombok.Setter;

@RequestMapping("/admin/member/*")
@Controller
public class AdminMemberController {

	@Setter(onMethod_ = {@Autowired})
	private AdminMemberService adminMemberService;
	
	/* ------------------------
	       회원 목록 : 페이징, 검색 추가
	 -------------------------- */
	@GetMapping("/memberList")
	public void memberList(@ModelAttribute("cri") Criteria cri, Model model) {
		
		cri.setAmount(5);
		
		List<MemberVO> memberList = adminMemberService.getListWithPaging(cri);
		
		// 페이징쿼리에 의한 회원 목록
		model.addAttribute("memberList", memberList);
		
		// 페이지 개수
		int totalCount = adminMemberService.getTotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, totalCount));
		
	}
	
	/* 회원 상세정보 */
	@GetMapping("/memberDetail")
	public void memberDetail(@RequestParam("mem_id") String mem_id, @ModelAttribute("cri") Criteria cri, Model model) {
		
		model.addAttribute("memberVO", adminMemberService.memberDetail(mem_id));
		
	}
	
	/* 회원 삭제 */
	@PostMapping("/memberDelete")
	public String memberDelete(@RequestParam("mem_id") String mem_id, Criteria cri) {
		
		adminMemberService.memberDelete(mem_id);
		
		return "redirect:/admin/member/memberList" + cri.getListLink();
	}
}
