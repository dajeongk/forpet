package com.forpet.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.forpet.dto.EmailDTO;
import com.forpet.service.EmailService;

import lombok.Setter;

@RequestMapping("/email/*")
@RestController
public class EmailController {

	@Setter(onMethod_ = {@Autowired})
	private EmailService service;
	
	/* --------------
	      메일 인증코드 전송
	 ---------------- */
	@GetMapping("/send") 
		public ResponseEntity<String> send(EmailDTO dto, HttpSession session) {
			
			ResponseEntity<String> entity = null;
			
			// 6자리 인증코드 생성
			String authCode = "";
			for(int i=0; i<6; i++) {
				authCode += String.valueOf((int)(Math.random()*10));
			}
			
			// 세션으로 서버측 메모리에 인증코드 생성
			session.setAttribute("authCode", authCode);
			
			// 메일 전송
			try {
				service.sendMail(dto, authCode);
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			}catch(Exception ex) {
				ex.printStackTrace();
				entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			
			return entity;
		}
	
}
