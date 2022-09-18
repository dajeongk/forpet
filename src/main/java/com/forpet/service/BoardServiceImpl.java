package com.forpet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.forpet.domain.BoardVO;
import com.forpet.dto.Criteria;
import com.forpet.mapper.BoardMapper;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardMapper boardMapper;
	
	/* 문의게시판 글 작성*/
	@Override
	public Long InsertSelectKey(BoardVO vo) {
		
		return boardMapper.InsertSelectKey(vo);
	}
	
	/* 문의게시판 글목록  */
	@Override
	public List<BoardVO> getBoardList() {
		
		return boardMapper.getBoardList();
	}

	/* 문의게시판 글목록 페이징 기능  */
	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		
		return boardMapper.getListWithPaging(cri);
	}

	/* 문의게시판 데이터 개수  */
	@Override
	public int getTotalCount(Criteria cri) {
		
		return boardMapper.getTotalCount(cri);
	}

	/* 문의게시판 글읽기 */
	@Override
	public BoardVO boardGet(Long brd_number) {
		
		return boardMapper.boardGet(brd_number);
	}

	/* 문의게시판 글수정*/
	@Override
	public void boardModify(BoardVO vo) {
		
		boardMapper.boardModify(vo);
	}

	/* 문의게시판 글삭제 */
	@Override
	public void boardDelete(Long brd_number) {
		
		boardMapper.boardDelete(brd_number);
	}
	
}
