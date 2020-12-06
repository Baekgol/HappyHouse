package com.ssafy.happyhouse.model.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.mapper.QnaMapper;
import com.ssafy.happyhouse.model.dto.QnaDto;
import com.ssafy.happyhouse.model.dto.QnaPageDto;

@Service
public class QnaService {
	@Autowired
	private SqlSession sqlSession;

	public static final int COUNT_PER_PAGE = 10;

	public QnaPageDto makePage(int curPage, int dealno) {
		int totalCnt = sqlSession.getMapper(QnaMapper.class).selectTotalCount();
		int totalPageCnt = totalCnt / COUNT_PER_PAGE;
		if (totalCnt % COUNT_PER_PAGE > 0)
			totalPageCnt++;

		int startPage = (curPage - 1) / 10 * 10 + 1;
		int endPage = startPage + 9;

		if (totalPageCnt < endPage)
			endPage = totalPageCnt;

		int startRow = (curPage - 1) * 10;
		ArrayList<QnaDto> qnaList = sqlSession.getMapper(QnaMapper.class).selectPage(startRow, COUNT_PER_PAGE, dealno);
		return new QnaPageDto(qnaList, curPage, startPage, endPage, totalPageCnt);
	}

	public List<QnaDto> searchAll(int dealno) {
		return sqlSession.getMapper(QnaMapper.class).searchAll(dealno);
	}

	public QnaDto searchOne(int id) {
		return sqlSession.getMapper(QnaMapper.class).searchOne(id);
	}

	public int insertQna(QnaDto dto) {
		return sqlSession.getMapper(QnaMapper.class).insertQna(dto);
	}

	public int updateQna(QnaDto dto) {
		return sqlSession.getMapper(QnaMapper.class).updateQna(dto);
	}

	public int deleteQna(int id) {
		return sqlSession.getMapper(QnaMapper.class).deleteQna(id);
	}
	
	public List<QnaDto> searchQnaByDealNo(int dealno){
		return sqlSession.getMapper(QnaMapper.class).searchQnaByDealNo(dealno);
	}

	public int updateAns(QnaDto dto) {
		return sqlSession.getMapper(QnaMapper.class).updateAns(dto);
	}
}
