package com.tistory.pentode.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tistory.pentode.service.BoardService;
import com.tistory.pentode.service.dao.BoardDAO;
import com.tistory.pentode.util.ExcelRead;
import com.tistory.pentode.util.ExcelReadOption;
import com.tistory.pentode.vo.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO boardMapper;

	@Override
	@Transactional
	public List<BoardVO> selectBoardList() throws Exception {
		return boardMapper.selectBoardList();
	}

	@Override
	public void insertBoard(BoardVO boardVO) {
		boardMapper.insertBoard(boardVO);
	}

	@Override
	public List<Map<String, Object>> allMember() {
		return boardMapper.allMember();
	}

	@SuppressWarnings("unchecked")
	@Override
	public void excelUpload(File destFile) {
		ExcelReadOption excelReadOption = new ExcelReadOption();

		// 파일경로 추가
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		// 추출할 컬럼 명 추가
		excelReadOption.setOutputColumns("A", "B", "C");
		System.out.println("excelReadOption :::: "+excelReadOption.getOutputColumns());
		// 시작 행
		excelReadOption.setStartRow(2);

		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
		
		System.out.println("excelContent :::: "+excelContent);
		System.out.println("excelContent.size :::: "+excelContent.size());

		//여기서 마지막 max(num) 가져와서 똑같이 파일 만들자.
		String maxNum = boardMapper.selectMaxNum();
		System.out.println("maxNum ::: "+maxNum);
		
//		((Map<String, Object>) excelContent).put("num", maxNum);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("excelContent", excelContent);
//		System.out.println("excelContent222222 :::: "+excelContent);
		try {
			boardMapper.insertExcel(paramMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
