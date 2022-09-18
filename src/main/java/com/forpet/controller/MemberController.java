package com.forpet.controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.forpet.domain.MemberVO;
import com.forpet.dto.EmailDTO;
import com.forpet.dto.LoginDTO;
import com.forpet.service.EmailService;
import com.forpet.service.MemberService;

import lombok.Setter;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	/* 스프링 시큐리티 클래스 주입  */
	@Setter(onMethod_ = {@Autowired})
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Setter(onMethod_ = {@Autowired})
	private MemberService memberservice;
	
	@Setter(onMethod_ = {@Autowired})
	private EmailService emailservice;
	
	/* -----------
	       회원가입 폼  
	 ------------- */
	@GetMapping("/join")
	public void join() {
		
	}
	
	/* -----------------------
	       회원가입 폼 : 회원정보 저장  
	 ------------------------- */
	@PostMapping("/join_ok")
	public String join_ok(MemberVO vo) throws Exception {
		
		String cryptEncoderPW = bCryptPasswordEncoder.encode(vo.getMem_pw());
		
		vo.setMem_pw(cryptEncoderPW);
		
		memberservice.join(vo);
			
		return "/member/login"; 
	}
	
	/* ----------------------
	       회원가입 폼 : ID 중복체크  
	 ------------------------ */
	@GetMapping("/idCheck")
	@ResponseBody
	public ResponseEntity<String> idCheck(@RequestParam("mem_id") String mem_id) {
		
		ResponseEntity<String> entity = null;
		
		// 아이디 존재여부
		String isUseId = "";
		
		if(memberservice.idCheck(mem_id) != null) {
			isUseId = "no";  // 아이디 존재 (사용 불가능)
		}else {
			isUseId = "yes"; // 아이디 미존재 (사용 가능)
		}
		
		entity = new ResponseEntity<String>(isUseId, HttpStatus.OK);
		
		return entity;
	}
	
	/* --------------------------
	       회원가입 폼 : 메일 인증코드 확인  
	 ---------------------------- */
	@PostMapping("/confirmAuthCode")
	@ResponseBody
	public ResponseEntity<String> confirmAuthCode(String userAuthCode, HttpSession session) {
		
		ResponseEntity<String> entity = null;
		
		// 사용자가 입력한 인증코드와 메일에 전송된 인증코드 비교
		String authCode = (String)session.getAttribute("authCode");
		if(userAuthCode.equals(authCode)) {
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
			
			// 세션 사용후 소멸
			session.removeAttribute("authCode");
			
		}else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		
		return entity;
	}
	
	/* ---------
	       로그인 폼  
	 ----------- */
	@GetMapping("/login")
	public void login() {
		
	}
	
	/* ------------------------
	       로그인 폼 : 로그인 정보 저장  
	 -------------------------- */
	@PostMapping("/login_ok")
	public String login_ok(LoginDTO dto, RedirectAttributes rttr, HttpSession session) throws Exception {
			
		// 로그인 정보 인증
		MemberVO vo = memberservice.login_ok(dto);
		
		String url = "";
		String msg = "";
		
		// 아이디가 존재하는 경우
		if(vo != null) {
			
			// 사용자가 입력한 평문텍스트(일반 비밀번호)와 DB에 저장된 암호화 비밀번호 비교
			// 1) 비밀번호 일치하는 경우 : 메인 페이지로 이동
			String pw = dto.getMem_pw();   // 사용자가 입력한 비밀번호
			String db_pw = vo.getMem_pw();  // DB에서 가져온 비밀번호
			
			if(bCryptPasswordEncoder.matches(pw, db_pw)) {
				url = "/";
				// 인증 성공시 서버측에 세션 정보 저장.
				session.setAttribute("loginStatus", vo);
				
				// 로그인 인터셉터에서 세션 형태로 저장한 주소
				String dest = (String) session.getAttribute("dest");
				url = (dest != null) ? dest : "/";
				
				msg = "loginSuccess";
			
			
			}else {
				// 2) 비밀번호 불일치하는 경우 : 로그인 폼으로 이동
				url = "/member/login";
				msg = "pwFail";
			}
			
		}else {
			// 아이디가 존재하지 않는 경우
			url = "/member/login";
			msg = "idFail";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return "redirect:" + url;
	
	}
	
	/* ---------
	       로그아웃  
	 ----------- */
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		// 로그아웃시 세션 소멸
		session.invalidate();
		
		rttr.addFlashAttribute("msg", "logout");
		
		return "redirect:/";
	}
	
	/* -------------
	       아이디 찾기 폼  
	 --------------- */
	@GetMapping("/findID")
	public void findID() {
		
	}
	
	/* ------------
	       아이디 찾기  
	 -------------- */
	@PostMapping("/findID")
	public String findID(@RequestParam("mem_name") String mem_name, @RequestParam("mem_email") String mem_email,
						  Model model, RedirectAttributes rttr) {
		
		String mem_id = memberservice.findID(mem_name, mem_email);
		String url = "";
		
		// 아이디 존재 유무 
		if(mem_id != null) {
			model.addAttribute("mem_id", mem_id);
			url = "/member/resultIDPW";
		}else {
			rttr.addFlashAttribute("msg", "noID");
			url = "/member/findID";
		}
		
		return url;
				
	}
	
	
	/* ---------------
	       비밀번호 찾기 폼  
	 ----------------- */
	@GetMapping("/findPW")
	public void findPW() {
		
	}
	
	/* ---------------------------
	       비밀번호 찾기 (임시비밀번호 발급) 
	 ----------------------------- */
	@PostMapping("/findPW")
	public String findPW(@RequestParam("mem_id") String mem_id, @RequestParam("mem_email") String mem_email,
						  Model model, RedirectAttributes rttr) {
		
		String db_mem_id = memberservice.findPW(mem_id, mem_email);
		String temp_mem_pw = "";
		String url = "";
		
		// 아이디 존재 유무
		if(db_mem_id != null) {
			
			// 1.임시비밀번호 생성
			UUID uuid = UUID.randomUUID();
			temp_mem_pw = uuid.toString().substring(0, 6);
			
			
			// 2.임시비밀번호를 암호화하여 DB에 저장
			memberservice.changePW(mem_id, bCryptPasswordEncoder.encode(temp_mem_pw));
			
			// 3.메일 전송
			EmailDTO dto = new EmailDTO("forpet", "forpet@email.com", mem_email, "임시 비밀번호입니다.", "");
			
			try {
				emailservice.sendMail(dto, temp_mem_pw);
				model.addAttribute("mail", "mail");
				url = "/member/resultIDPW";				
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		
		}else {
			rttr.addFlashAttribute("msg", "noID");
			url = "redirect:/member/findPW";
		}
		
		return url;
	}
	
	/* -------------------------------
	       회원정보 수정을 위한 비밀번호 재확인 폼  
	 --------------------------------- */
	@GetMapping("/confirmPW")
	public void confirmPW() {
		
	}
	
	/* --------------------------------------------
	       회원정보 수정을 위한 비밀번호 재확인 폼  : 로그인정보 저장
	----------------------------------------------- */
	@PostMapping("/confirmPW")
	public String confirmPW(@RequestParam("mem_pw") String mem_pw, HttpSession session, RedirectAttributes rttr) {
		
		String url = "";
		
		// 로그인시 세션에서 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		// 로그인시 사용한 정보
		LoginDTO dto = new LoginDTO(mem_id, mem_pw);
		MemberVO vo = memberservice.login_ok(dto);
		
		if(vo != null) {
			
			String db_pw = vo.getMem_pw();
			
			// 비밀번호 일치하는 경우
			if(bCryptPasswordEncoder.matches(mem_pw, db_pw)) {
				url = "member/modify";
			}else { // 비밀번호 불일치하는 경우
				rttr.addFlashAttribute("msg", "noPW");
				url = "member/confirmPW";
			}
		}
		
		
		return "redirect:/" + url;
	}
	
	/* --------------
	       회원정보 수정 폼  
	 ---------------- */
	@GetMapping("/modify")
	public void modify(HttpSession session, Model model) {
		
		// 세션에서 로그인시 사용한 정보
		String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		// 비밀번호는 쿼리에서 사용하지 않아 공백으로 처리
		LoginDTO dto = new LoginDTO(mem_id, "");

		// 로그인 쿼리와 회원 수정 폼 쿼리 동일하여 재사용
		MemberVO vo = memberservice.login_ok(dto);
		
		model.addAttribute("memberVO", vo);
	}
	
	/* ---------------------------
	       회원정보 수정 폼  : 회원정보 저장  
	 ----------------------------- */
	@PostMapping("/modify_ok")
	public String modify_ok(MemberVO vo, HttpSession session) {
			
		if(vo.getMem_pw().equals(""));
		
		if(vo.getMem_pw() != null && !vo.getMem_pw().equals("")) {
						
			// 평문 텍스트비밀번호 -> 암호화된 비밀번호로 변경
			String cryptEncoderPW = bCryptPasswordEncoder.encode(vo.getMem_pw());
			vo.setMem_pw(cryptEncoderPW);
		}
		
		memberservice.modify(vo);
		
		session.invalidate();
			
		return "/member/login";
	}
}