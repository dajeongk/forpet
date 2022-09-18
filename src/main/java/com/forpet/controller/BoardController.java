package com.forpet.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.forpet.domain.BoardVO;
import com.forpet.domain.MemberVO;
import com.forpet.dto.Criteria;
import com.forpet.dto.PageDTO;
import com.forpet.service.BoardService;

import lombok.Setter;

@RequestMapping("/user/board/*")
@Controller
public class BoardController {

	@Setter(onMethod_ = {@Autowired})
	private BoardService boardService;
	
	
	/* ----------------
	       문의게시판 글 작성
	 ------------------ */
	@GetMapping("/boardWrite")
	public void boardWrite() {
		
	}
	
	/* ----------------
	       문의게시판 글 저장 
	 ------------------ */
	@PostMapping("/boardWrite")
	public String boardWrite(BoardVO vo, HttpSession session) {
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		vo.setMem_id(mem_id);
		
		boardService.InsertSelectKey(vo);	
			
		return "redirect:/user/board/boardList";
	}
	
	/* ----------------
	       문의게시판 글 목록  
	 ------------------ */
	@GetMapping("/boardList")
	public void boardList(Criteria cri, Model model) {
		
		List<BoardVO> boardList = boardService.getListWithPaging(cri);
		model.addAttribute("boardList", boardList);
		
		int total = boardService.getTotalCount(cri);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		model.addAttribute("pageMaker", pageDTO);
	}
	
	/* ----------------
	       문의게시판 글 읽기 
	 ------------------ */
	@GetMapping(value = {"/boardGet" ,"/boardModify"})
	public void boardGet(@RequestParam("brd_number") Long brd_number, @ModelAttribute("cri") Criteria cri, Model model) {
		
		BoardVO board = boardService.boardGet(brd_number);
		
		model.addAttribute("board", board);
	}

	/* ----------------
	       문의게시판 글 수정 
	 ------------------ */
	@PostMapping("/boardModify")
	public String modify(BoardVO vo, @ModelAttribute("cri") Criteria cri) {
		
		boardService.boardModify(vo);
				
		return "redirect:/user/board/boardList" + cri.getListLink();
	}
	
	/* ----------------
	       문의게시판 글 삭제 
	 ------------------ */
	@PostMapping("/boardDelete")
	public String boardDelete(@RequestParam("brd_number") Long brd_number, Criteria cri) {
		
		boardService.boardDelete(brd_number);
		
		return "redirect:/user/board/boardList" + cri.getListLink();
	}
	
	
	
	
}
