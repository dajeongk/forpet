package com.forpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	
	/* 주문 테이블 */	
	private Long odr_number;
	private String mem_id;
	private String odr_name;
	private String odr_phone;
	private String odr_postcode;
	private String odr_addr;
	private String odr_addr_d;
	private int odr_total_price;
	private Date odr_date;
	private String odr_message;

	private String odr_status;	// 주문상태 : 배송상태
	private String pay_status;	// 결제상태 : 입금상태
	private String cs_status;	// cs상태	 : 교환 및 환불, 취소상태
	
	// 주문테이블 기록 
	private Date odr_event_date;
	private String event_name;
}
