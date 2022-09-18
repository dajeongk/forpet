package com.forpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.forpet.domain.ReviewVO;
import com.forpet.dto.Criteria;
import com.forpet.mapper.ReviewMapper;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Setter(onMethod_ = {@Autowired})
	private ReviewMapper reviewMapper;
	
	/* 상품후기 작성 */
	@Transactional
	@Override
	public Integer create(ReviewVO vo) {
	
		reviewMapper.create(vo);
		
		// 상품후기 개수 업데이트		
		reviewMapper.reviewCountUpdate(vo.getPdt_number(), 1);
		
		return reviewMapper.reviewCountByProduct(vo.getPdt_number());
	}

	/* 상품후기 목록 */
	@Override
	public List<ReviewVO> list(Integer pdt_number, Criteria cri) {
		
		return reviewMapper.list(pdt_number, cri);
	}

	/* 상품후기 개수 */
	@Override
	public Integer listCount(Integer pdt_number) {
		
		return reviewMapper.listCount(pdt_number);
	}
	
	/* 상품후기 수정 */
	@Override
	public void modify(ReviewVO vo) {
		
		reviewMapper.modify(vo);
	}

	/* 상품후기 삭제 */
	@Transactional
	@Override
	public Integer delete(Integer rvw_number) {				
		
		// 상품후기 삭제시 rvw_number를 파라미터로 받기 때문에 번호에 해당하는 리뷰를 알아야함.
		ReviewVO vo = reviewMapper.read(rvw_number);
			
		reviewMapper.delete(rvw_number);
		
		// 상품후기 개수 업데이트
		reviewMapper.reviewCountUpdate(vo.getPdt_number(), -1);
		
		System.out.println("댓글삭제: " + vo);
		
		return reviewMapper.reviewCountByProduct(vo.getPdt_number());
	}


}
