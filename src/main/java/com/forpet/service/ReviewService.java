package com.forpet.service;

import java.util.List;

import com.forpet.domain.ReviewVO;
import com.forpet.dto.Criteria;

public interface ReviewService {
	
	/* 상품후기 작성 */
	Integer create(ReviewVO vo);
	
	/* 상품후기 목록 */
	List<ReviewVO> list(Integer pdt_number, Criteria cri);

	/* 상품후기 개수 */
	Integer listCount(Integer pdt_number);
	
	/* 상품후기 수정 */
	void modify(ReviewVO vo);
	
	/* 상품후기 삭제 */
	Integer delete(Integer rvw_number);

}
