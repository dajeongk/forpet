package com.forpet.mapper;

import java.util.List;


import com.forpet.domain.BoardVO;
import com.forpet.dto.Criteria;

public interface BoardMapper {

	/* 문의게시판 글 작성*/
	Long InsertSelectKey(BoardVO vo);
	
	/* 문의게시판 글목록  */
	List<BoardVO> getBoardList();
	
	/* 문의게시판 글목록 페이징 기능  */
	List<BoardVO> getListWithPaging(Criteria cri);
	
	/* 문의게시판 데이터 개수  */
	int getTotalCount(Criteria cri);
	
	/* 문의게시판 글읽기 */
	BoardVO boardGet(Long brd_number);
	
	/* 문의게시판 글수정*/
	void boardModify(BoardVO vo);
	
	/* 문의게시판 글삭제 */
	void boardDelete(Long brd_number);
}
