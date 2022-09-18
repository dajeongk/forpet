package com.forpet.mapper;

import org.apache.ibatis.annotations.Param;

import com.forpet.domain.MemberVO;
import com.forpet.dto.LoginDTO;

public interface MemberMapper {
	
	/* 회원가입 : 회원정보 저장  */
	void join(MemberVO vo);
	
	/* 회원가입 : ID 중복체크  */
	String idCheck(String mem_id);
	
	/* 로그인  */ 
	MemberVO login_ok(LoginDTO dto);
	
	/* 아이디 찾기  */
	String findID(@Param("mem_name") String mem_name, @Param("mem_email") String mem_email);
	
	/* 비밀번호 찾기 (임시비밀번호 발급) */
	String findPW(@Param("mem_id") String mem_id, @Param("mem_email") String mem_email);
	
	/* 임시비밀번호를 암호화하여 변경  */
	void changePW(@Param("mem_id") String mem_id, @Param("mem_pw") String enc_mem_pw);

	/* 회원정보 수정  */
	void modify(MemberVO vo);
	
}
