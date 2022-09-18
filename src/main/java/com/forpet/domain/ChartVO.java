package com.forpet.domain;

import lombok.Data;

@Data
public class ChartVO {
	
	/* 차트 정보 */
	private String primary_code;	// 1차 카테고리 이름
	private int sales_p;			// 1차 카테고리 별 매출 통계
	private String secondary_code;	// 2차 카테고리 이름
	private int sales_s;			// 2차 카테고리 별 매출 통계
	
	private String month;			// 각 월
	private int month_sales;		// 월별 매출
	private String year;			// 각 년도
	private int total;				// 년도별 총 매출
}
