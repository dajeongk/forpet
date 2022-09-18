package com.forpet.domain;

import lombok.Data;

@Data
public class CartVOList {

	// CartVO클래스 참조
	private Long crt_code;
	private Integer pdt_number;
	private String mem_id;
	private int pdt_buy_amount;
	
	// ProductVO클래스 참조
	private String pdt_img_folder;
	private String pdt_img;
	private String pdt_name;
	private int pdt_price;
	
	// MemberVO 클래스 참조
	private int mem_point;
}
