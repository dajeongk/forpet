package com.forpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.forpet.domain.CategoryVO;
import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;

public interface UserProductMapper {
	
	/* 1차 카테고리 리스트 */
	List<CategoryVO> getCategoryList();
	
	/* 2차 카테고리 리스트 */
	List<CategoryVO> getSubCategoryList(Integer ctg_code);
	
	/* 2차 카테고리 : 상품목록 */
	List<ProductVO> getProductListBySubCategory(@Param("ctg_code") Integer ctg_code, @Param("cri") Criteria cri);
	
	/* 2차 카테고리 : 상품개수 */
	int getProductCountBySubCategory(@Param("ctg_code") Integer ctg_code, @Param("cri") Criteria cri);
	
	/* 모달상자 : 상품코드에 해당하는 상품 상세정보 */
	ProductVO getProductByNum(Integer pdt_number);
	
	/* 베스트 카테고리에 해당하는 상품 리스트 */
	List<ProductVO> bestCategoryList(Integer ctg_code);
	
}
