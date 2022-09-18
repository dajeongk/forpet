package com.forpet.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {
	
	/* 상품 테이블 */
	private Integer pdt_number;     
	private Integer ctg_code;		 	
	private Integer ctg_code_prt;	 
	private String pdt_name;
	private int pdt_price;
	private int pdt_discount;
	private String pdt_company;
	private String pdt_img_folder;	 
	private String pdt_img;	         
	private String pdt_detail;
	private int pdt_buy_amount;
	private int pdt_sell_amount;
	private String pdt_buy_accept;
	private Date pdt_sign_date;
	private Date pdt_update_date;
	
	private Integer rvw_cnt;
		
	// 상품 이미지 파일(업로드)
	private MultipartFile uploadFile;
}
