package com.forpet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.MemberVO;
import com.forpet.dto.LoginDTO;
import com.forpet.mapper.MemberMapper;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	
	/* 회원가입 - 회원정보 저장  */
	@Override
	public void join(MemberVO vo) {
		
		mapper.join(vo);
	}

	/* 회원가입 - ID 중복체크  */
	@Override
	public String idCheck(String mem_id) {
		
		return mapper.idCheck(mem_id);
	}

	/* 로그인  */
	@Override
	public MemberVO login_ok(LoginDTO dto) {
		
		return mapper.login_ok(dto);
	}
	
	/* 아이디 찾기  */
	@Override
	public String findID(String mem_name, String mem_email) {
		
		return mapper.findID(mem_name, mem_email);
	}
	
	/* 비밀번호 찾기 (임시비밀번호 발급) */
	@Override
	public String findPW(String mem_id, String mem_email) {
		
		return mapper.findPW(mem_id, mem_email);
	}

	/* 임시비밀번호를 암호화하여 변경  */
	@Override
	public void changePW(String mem_id, String enc_mem_pw) {
		
		mapper.changePW(mem_id, enc_mem_pw);
	}

	/* 회원정보 수정  */
	@Override
	public void modify(MemberVO vo) {
		
		mapper.modify(vo);
	}

}
