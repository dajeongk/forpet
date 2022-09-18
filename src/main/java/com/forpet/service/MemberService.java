package com.forpet.service;

import com.forpet.domain.MemberVO;
import com.forpet.dto.LoginDTO;

public interface MemberService {
	
	/* 회원가입 - 회원정보 저장  */
	void join(MemberVO vo);
	
	/* 회원가입 - ID 중복체크  */
	String idCheck(String mem_id);
	
	/* 로그인  */
	MemberVO login_ok(LoginDTO dto);
	
	/* 아이디 찾기  */
	String findID(String mem_name, String mem_email);
	
	/* 비밀번호 찾기 (임시비밀번호 발급) */
	String findPW(String mem_id, String mem_email);
	
	/* 임시비밀번호를 암호화하여 변경  */
	void changePW(String mem_id, String enc_mem_pw);
	
	/* 회원정보 수정  */
	void modify(MemberVO vo);
	
}
