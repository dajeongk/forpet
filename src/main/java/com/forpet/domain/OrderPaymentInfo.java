package com.forpet.domain;

import lombok.Data;

@Data
public class OrderPaymentInfo {

	/* 주문결제 정보 */
	
	// 주문 테이블
	private Long odr_number;
	private String mem_id;
	private String odr_name;
	private String odr_phone;
	private String odr_postcode;
	private String odr_addr;
	private String odr_addr_d;
	private int odr_total_price;
	private String odr_message;
	private String odr_status;
	private String pay_status;
	private String cs_status;
	
	// 결제 테이블
	private int pay_total_price;
	private String pay_method;
	private int pay_rest_price;
	private int pay_nobank_price;
	private String pay_nobank_user;
	private String pay_nobank;
	
}
