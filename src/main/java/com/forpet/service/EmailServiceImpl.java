package com.forpet.service;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.forpet.dto.EmailDTO;

import lombok.Setter;

@Service
public class EmailServiceImpl implements EmailService {
	
	@Setter(onMethod_ = {@Autowired})
	private JavaMailSender mailSender;
	
	/* 메일 전송 */
	@Override
	public void sendMail(EmailDTO dto, String authCode) {
		
		// 메일 구성정보를 담당하는 객체 (수신자, 발신자, 이메일주소, 제목, 본문내용)
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			// 수신자의 메일주소
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			// 발신자의 정보(메일주소, 이름)
			msg.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
			// 메일 제목
			msg.setSubject(dto.getSubject(), "utf-8");
			// 메일 내용
			msg.setText(authCode, "utf-8");
			
			mailSender.send(msg);
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
	}

}
