package com.tistory.pentode.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tistory.pentode.vo.BoardVO;

public interface BoardService {
	List<BoardVO> selectBoardList() throws Exception;
	void insertBoard(BoardVO boardVO);
	List<Map<String, Object>> allMember();
	void excelUpload(File destFile);

	
	
}
