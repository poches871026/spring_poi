package com.tistory.pentode.service.dao;

import java.util.List;
import java.util.Map;

import com.tistory.pentode.vo.BoardVO;

public interface BoardDAO {
	
	List<BoardVO> selectBoardList() throws Exception;

	void insertBoard(BoardVO boardVO);

	List<Map<String, Object>> allMember();

	void insertExcel(Map<String, Object> paramMap);

	String selectMaxNum();

}
