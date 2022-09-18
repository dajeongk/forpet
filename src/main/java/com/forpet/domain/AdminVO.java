package com.forpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AdminVO {
	
	/* 관리자 테이블 */	
	private String adm_id;
	private String adm_pw;
	private String adm_name;
	private Date adm_login_date;
}
