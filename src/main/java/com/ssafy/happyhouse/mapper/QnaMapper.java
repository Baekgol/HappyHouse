package com.ssafy.happyhouse.mapper;

import java.util.ArrayList;
import java.util.List;

import com.ssafy.happyhouse.model.dto.QnaDto;

public interface QnaMapper {
	public int selectTotalCount();
	public ArrayList<QnaDto> selectPage(int startRow, int countPerPage, int dealno);
	public List<QnaDto> searchAll(int dealno);
	public QnaDto searchOne(int id);
	public int insertQna(QnaDto dto);
	public int updateQna(QnaDto dto);
	public int deleteQna(int id);
	
	public int updateAns(QnaDto dto);
	
	public List<QnaDto> searchQnaByDealNo(int dealno);	// 매물별 qna 가져오기
}
