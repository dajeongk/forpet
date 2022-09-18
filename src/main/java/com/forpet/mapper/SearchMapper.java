package com.forpet.mapper;

import java.util.List;

import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;

public interface SearchMapper {

	/* 검색 상품목록 */
	List<ProductVO> getSearchProductList(Criteria cri);
	
	/* 검색 상품개수 */
	int getSearchProductCount(Criteria cri);
}
