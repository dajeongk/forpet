package com.forpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.ChartVO;
import com.forpet.mapper.AdminChartMapper;

import lombok.Setter;

@Service
public class AdminChartServiceImpl implements AdminChartService {

	@Setter(onMethod_ = {@Autowired})
	private AdminChartMapper chartMapper;
	
	/* 1차 카테고리 이름별 매출 통계 */
	@Override
	public List<ChartVO> primaryChart() {
		
		return chartMapper.primaryChart();
	}

}
