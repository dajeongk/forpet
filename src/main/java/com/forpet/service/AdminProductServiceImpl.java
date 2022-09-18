package com.forpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.CategoryVO;
import com.forpet.domain.ProductVO;
import com.forpet.dto.Criteria;
import com.forpet.mapper.AdminProductMapper;

import lombok.Setter;

@Service
public class AdminProductServiceImpl implements AdminProductService {
	
	@Setter(onMethod_ = {@Autowired})
	private AdminProductMapper productMapper;
	
	/* 1차 카테고리 리스트  */
	@Override
	public List<CategoryVO> getCateList() {
		
		return productMapper.getCateList();
	}
	
	/* 2차 카테고리 리스트  */
	@Override
	public List<CategoryVO> getSubCateList(Integer categoryCode) {
		
		return productMapper.getSubCateList(categoryCode);
	}
	
	/* 상품 정보 등록  */
	@Override
	public void productInsert(ProductVO vo) {
		
		productMapper.productInsert(vo);
	}

	/* 상품 목록  */
	@Override
	public List<ProductVO> getProductList(Criteria cri) {
		
		return productMapper.getProductList(cri);
	}

	/* 상품 데이터 개수  */
	@Override
	public int getProductTotalCount(Criteria cri) {
		
		return productMapper.getProductTotalCount(cri);
	}
	
	/* 상품수정 폼 : 상품코드에 해당하는 상품정보  */
	@Override
	public ProductVO getProductByNum(Integer pdt_number) {
		
		return productMapper.getProductByNum(pdt_number);
	}

	/* 상품 정보 수정  */
	@Override
	public void productModify(ProductVO vo) {
		
		productMapper.productModify(vo);
	}

	/* 상품 정보 삭제 */
	@Override
	public void productDelete(Integer pdt_number) {
		
		productMapper.productDelete(pdt_number);
	}

}
