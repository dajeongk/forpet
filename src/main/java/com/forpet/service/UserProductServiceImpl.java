package com.forpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.CategoryVO;
import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;
import com.forpet.mapper.UserProductMapper;

import lombok.Setter;

@Service
public class UserProductServiceImpl implements UserProductService {
	
	@Setter(onMethod_ = {@Autowired})
	private UserProductMapper userProductMapper;
	
	/* 1차 카테고리 리스트  */
	@Override
	public List<CategoryVO> getCategoryList() {
		
		return userProductMapper.getCategoryList();
	}

	/* 2차 카테고리 리스트  */
	@Override
	public List<CategoryVO> getSubCategoryList(Integer ctg_code) {
		
		return userProductMapper.getSubCategoryList(ctg_code);
	}

	/* 2차 카테고리 : 상품목록  */
	@Override
	public List<ProductVO> getProductListBySubCategory(Integer ctg_code, Criteria cri) {
		
		return userProductMapper.getProductListBySubCategory(ctg_code, cri);
	}

	/* 2차 카테고리 : 상품개수  */
	@Override
	public int getProductCountBySubCategory(Integer ctg_code, Criteria cri) {
		
		return userProductMapper.getProductCountBySubCategory(ctg_code, cri);
	}

	/* 모달상자 : 상품코드에 해당하는 상품 상세정보 */
	@Override
	public ProductVO getProductByNum(Integer pdt_number) {
		
		return userProductMapper.getProductByNum(pdt_number);
	}

	/* 베스트 카테고리에 해당하는 상품 리스트 */
	@Override
	public List<ProductVO> bestCategoryList(Integer ctg_code) {
		
		return userProductMapper.bestCategoryList(ctg_code);
	}


}
