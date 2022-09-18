package com.forpet.domain;

import lombok.Data;

@Data
public class CartOrderInfo {

	/* 주문내역 정보 */
	private Integer pdt_number;
	private String mem_id;
	private int pdt_buy_amount;
	private String pdt_name;
	private int pdt_price;
	private int pdt_discount;
	private String pdt_company;
	private String pdt_img_folder;	 
	private String pdt_img;

}
