package com.forpet.mapper;

import java.util.List;

import com.forpet.domain.ChartVO;

public interface AdminChartMapper {

	/* 1차 카테고리 이름별 매출 통계 */
	List<ChartVO> primaryChart();
}
