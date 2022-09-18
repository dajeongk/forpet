package com.forpet.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class EmailDTO {
	
	// 메일 전송시 필요한 데이터
	private String senderName;   // 발신자 이름
	private String senderMail;   // 발신자 메일주소
	private String receiveMail;  // 수신자 메일주소
	private String subject;      // 제목
	private String message;      // 본문
	
	public EmailDTO() {
		this.senderName = "forpet";
		this.senderMail = "forpet@email.com";
		this.subject = "회원가입 메일 인증코드입니다.";
		this.message = "인증코드";
	}
}
