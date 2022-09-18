package com.forpet.mapper;

import java.util.List;

import com.forpet.domain.MemberVO;
import com.forpet.dto.Criteria;

public interface AdminMemberMapper {

	/* 회원목록 페이징 기능  */
	List<MemberVO> getListWithPaging(Criteria cri);
	
	/* 회원 데이터 개수  */
	int getTotalCount(Criteria cri);
	
	/* 회원 상세정보*/
	MemberVO memberDetail(String mem_id);
	
	/* 회원 삭제 */
	void memberDelete(String mem_id);
}
