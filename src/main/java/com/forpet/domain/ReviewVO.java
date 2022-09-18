package com.forpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {

	/* 리뷰 테이블 */
	private Integer rvw_number;
	private String mem_id;
	private Integer pdt_number;
	private String rvw_content;
	private int rvw_score;
	private Date rvw_date;

}
