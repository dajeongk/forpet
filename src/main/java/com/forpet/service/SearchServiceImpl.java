package com.forpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;
import com.forpet.mapper.SearchMapper;

import lombok.Setter;

@Service
public class SearchServiceImpl implements SearchService {

	@Setter(onMethod_ = {@Autowired})
	private SearchMapper searchMapper;

	/* 검색 상품목록 */
	@Override
	public List<ProductVO> getSearchProductList(Criteria cri) {
		
		return searchMapper.getSearchProductList(cri);
	}

	/* 검색 상품개수 */
	@Override
	public int getSearchProductCount(Criteria cri) {
		
		return searchMapper.getSearchProductCount(cri);
	}
}
