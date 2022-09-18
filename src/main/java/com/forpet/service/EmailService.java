package com.forpet.service;

import com.forpet.dto.EmailDTO;

public interface EmailService {

	/* 메일 전송 */
	void sendMail(EmailDTO dto, String authCode);
}
