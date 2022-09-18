package com.forpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {

	/* 회원 테이블 */	
	private String mem_id;
	private String mem_pw;
	private String mem_name;
	private String mem_phone;
	private String mem_email;
	private String mem_authcode; 
	private String mem_postcode;
	private String mem_addr;
	private String mem_addr_d;
	private String mem_point;
	private Date mem_sign_date;
	private Date mem_update_date;
	private Date mem_last_date;

}
