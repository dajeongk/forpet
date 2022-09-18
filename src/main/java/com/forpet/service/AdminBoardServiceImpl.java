package com.forpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.BoardVO;
import com.forpet.dto.Criteria;
import com.forpet.mapper.AdminBoardMapper;

import lombok.Setter;

@Service
public class AdminBoardServiceImpl implements AdminBoardService {

	@Setter(onMethod_ = {@Autowired})
	private AdminBoardMapper adminBoardMapper;
	
	/* 문의게시판 글목록 페이징 기능  */
	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		
		return adminBoardMapper.getListWithPaging(cri);
	}
	
	/* 문의게시판 데이터 개수  */
	@Override
	public int getTotalCount(Criteria cri) {
		
		return adminBoardMapper.getTotalCount(cri);
	}

	/* 문의게시판 글읽기 */
	@Override
	public BoardVO boardGet(Long brd_number) {
		
		return adminBoardMapper.boardGet(brd_number);
	}
	
	/* 문의게시판 글삭제 */
	@Override
	public void boardDelete(Long brd_number) {
		
		adminBoardMapper.boardDelete(brd_number);
	}

}
