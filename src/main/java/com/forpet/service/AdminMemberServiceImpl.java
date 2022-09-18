package com.forpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.MemberVO;
import com.forpet.dto.Criteria;
import com.forpet.mapper.AdminMemberMapper;

import lombok.Setter;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {

	@Setter(onMethod_ = {@Autowired})
	private AdminMemberMapper adminMemberMapper;
	
	/* 회원목록 페이징 기능  */
	@Override
	public List<MemberVO> getListWithPaging(Criteria cri) {
		
		return adminMemberMapper.getListWithPaging(cri);
	}

	/* 회원 데이터 개수  */
	@Override
	public int getTotalCount(Criteria cri) {
		
		return adminMemberMapper.getTotalCount(cri);
	}

	/* 회원 상세정보*/
	@Override
	public MemberVO memberDetail(String mem_id) {
		
		return adminMemberMapper.memberDetail(mem_id);
	}

	/* 회원 삭제 */
	@Override
	public void memberDelete(String mem_id) {

		adminMemberMapper.memberDelete(mem_id);
	}

}
