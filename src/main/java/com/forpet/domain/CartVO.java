package com.forpet.domain;

import lombok.Data;

@Data
public class CartVO {
	
	/* 장바구니 테이블 */
	private Long crt_code;
	private Integer pdt_number;
	private String mem_id;
	private int pdt_buy_amount;

}
