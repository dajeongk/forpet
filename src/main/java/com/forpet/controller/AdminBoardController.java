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

import com.forpet.domain.BoardVO;
import com.forpet.dto.Criteria;
import com.forpet.dto.PageDTO;
import com.forpet.service.AdminBoardService;

import lombok.Setter;

@RequestMapping("/admin/board/*")
@Controller
public class AdminBoardController {

	@Setter(onMethod_ = {@Autowired})
	private AdminBoardService adminBoardService;
	
	/* ----------------
	       문의게시판 글 목록 
	 ------------------ */
	@GetMapping("/boardList")
	public void adminBoardList(Criteria cri, Model model) {
		
		List<BoardVO> boardList = adminBoardService.getListWithPaging(cri);
		model.addAttribute("boardList", boardList);
		
		int total = adminBoardService.getTotalCount(cri);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
	}
	
	/* ----------------
	       문의게시판 글읽기 
	 ------------------ */
	@GetMapping("/boardGet")
	public void boardGet(@RequestParam("brd_number") Long brd_number, @ModelAttribute("cri") Criteria cri, Model model) {
		
		BoardVO board = adminBoardService.boardGet(brd_number);
		
		model.addAttribute("board", board);
	}
	
	/* ----------------
	       문의게시판 글삭제 
	 ------------------ */
	@PostMapping("/boardDelete")
	public String boardDelete(@RequestParam("brd_number") Long brd_number, Criteria cri) {
		
		adminBoardService.boardDelete(brd_number);
		
		return "redirect:/admin/board/boardList" + cri.getListLink();
	}
}
