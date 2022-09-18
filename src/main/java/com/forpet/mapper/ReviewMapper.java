package com.forpet.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.forpet.domain.ReviewVO;
import com.forpet.dto.Criteria;

public interface ReviewMapper {
	
	/* 상품후기 작성 */
	Integer create(ReviewVO vo);

	/* 상품후기 목록 */
	List<ReviewVO> list(@Param("pdt_number") Integer pdt_number, @Param("cri") Criteria cri);

	/* 상품후기 전체 개수 */
	Integer listCount(Integer pdt_number);
	
	/* 상품후기 수정 */
	void modify(ReviewVO vo);
	
	/* 상품후기 삭제 */
	Integer delete(Integer rvw_number);
	
	/* 상품번호에 해당하는 리뷰 */
	ReviewVO read(Integer rvw_number);
	
	/* 리뷰 개수  */
	Integer reviewCountUpdate(@Param("pdt_number") Integer pdt_number, @Param("amount") int amount);
	
	/* 상품에 해당하는 리뷰 개수  */
	Integer reviewCountByProduct(Integer pdt_number);
}
