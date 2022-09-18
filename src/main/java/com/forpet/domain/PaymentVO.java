package com.forpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PaymentVO {
	

	/* 결제 테이블 */
	private Integer pay_code;	 
	private Long odr_number;	 
	private String pay_method;	 
	private Date pay_date;		 
	private int pay_total_price;
	private int pay_rest_price;
	private int pay_nobank_price;
	private String pay_nobank_user;
	private String pay_nobank;

}
