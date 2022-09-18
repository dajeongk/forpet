package com.forpet.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.AdminVO;
import com.forpet.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Setter(onMethod_ = {@Autowired})
	private AdminMapper adminMapper;
	
	/* 관리자 로그인  */
	@Override
	public AdminVO admLogin_ok(AdminVO vo) {
		
		return adminMapper.admLogin_ok(vo);
	}

}
