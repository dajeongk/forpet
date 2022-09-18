package com.forpet.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.forpet.domain.AdminVO;
import com.forpet.service.AdminService;

import lombok.Setter;

@RequestMapping("/admin/*")
@Controller
public class AdminController {
	
	/* 스프링 시큐리티 클래스 주입  */
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Setter(onMethod_ = {@Autowired})
	private AdminService adminService;
	
	/* ------------
	       관리자 로그인   
	 -------------- */
	@GetMapping("")
	public String main() {
		
		return "/admin/admLogin";
	}

	/* --------------------------
	       관리자 로그인 : 로그인 정보 저장  
	 ---------------------------- */
	@PostMapping("/admLogin_ok")
	public String admLogin_ok(AdminVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		String url = "";
		String msg = "";
		
		AdminVO dbAdminVO = adminService.admLogin_ok(vo);
		
		// 아이디가 존재하는 경우
		if(dbAdminVO != null) {
			
			// 1.비밀번호가 일치하는 경우
			if(bCryptPasswordEncoder.matches(vo.getAdm_pw(), dbAdminVO.getAdm_pw())) {
			session.setAttribute("adminStatus", dbAdminVO);
			url = "admin/adminMain";
			} 
			// 2.비밀번호가 불일치하는 경우
			else {
				url = "admin/admLogin";
				msg = "noPW";
			}
		}
		// 3.아이디가 존재하지 않는 경우 
		else {
			url = "admin/admLogin";
			msg = "noID";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return "redirect:/" + url;
	}
	
	/* --------- 
	       로그아웃  
	 -----------*/
	@GetMapping("/admLogout")
	public String admLogout(HttpSession session, RedirectAttributes rttr) {
		
		session.invalidate();
		
		rttr.addFlashAttribute("msg", "admLogout");
		
		return "redirect:/admin/";
	}
	
	/* -----------
	       메인 페이지  
	 ------------- */
	@GetMapping("/adminMain")
	public String adminMain() {
		
		return "/admin/main";
	}

}
