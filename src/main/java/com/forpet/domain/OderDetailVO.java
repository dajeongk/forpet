package com.forpet.domain;

import lombok.Data;

@Data
public class OderDetailVO {
	
	/* 주문상세 테이블 */
	private Long odr_number;
	private Integer pdt_number;
	private int odr_amount;
	private int odr_price;	// 상품가격 * 수량
}
