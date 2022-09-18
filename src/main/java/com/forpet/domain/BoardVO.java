package com.forpet.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	/* 게시판 테이블 */	
	private Long brd_number;
	private String mem_id;
	private String brd_title;
	private String brd_content;
	private Date brd_date;
}
