package com.forpet.service;

import java.util.List;

import com.forpet.domain.CategoryVO;
import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;

public interface UserProductService {

	/* 1차 카테고리 리스트  */
	List<CategoryVO> getCategoryList();
	
	/* 2차 카테고리 리스트  */
	List<CategoryVO> getSubCategoryList(Integer ctg_code);
	
	/* 2차 카테고리 : 상품목록  */
	List<ProductVO> getProductListBySubCategory(Integer ctg_code, Criteria cri);
	
	/* 2차 카테고리 : 상품개수  */
	int getProductCountBySubCategory(Integer ctg_code, Criteria cri);

	/* 모달상자 : 상품코드에 해당하는 상품 상세정보 */
	ProductVO getProductByNum(Integer pdt_number);
	
	/* 베스트 카테고리에 해당하는 상품 리스트 */
	List<ProductVO> bestCategoryList(Integer ctg_code);
	
}
