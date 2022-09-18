package com.forpet.mapper;

import java.util.List;

import com.forpet.domain.CategoryVO;
import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;

public interface AdminProductMapper {
	
	/* 1차 카테고리 리스트  */
	List<CategoryVO> getCateList();
	
	/* 2차 카테고리 리스트  */
	List<CategoryVO> getSubCateList(Integer categoryCode);
	
	/* 상품 정보 등록  */
	void productInsert(ProductVO vo);
	
	/* 상품 목록  */
	List<ProductVO> getProductList(Criteria cri);
	
	/* 상품 데이터 개수  */
	int getProductTotalCount(Criteria cri);
	
	/* 상품수정 폼 : 상품코드에 해당하는 상품정보  */
	ProductVO getProductByNum(Integer pdt_number);
	
	/* 상품 정보 수정  */
	void productModify(ProductVO vo);
	
	/* 상품 정보 삭제  */
	void productDelete(Integer pdt_number);

}
