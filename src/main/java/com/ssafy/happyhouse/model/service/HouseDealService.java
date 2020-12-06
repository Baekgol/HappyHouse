package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.mapper.HouseDealMapper;
import com.ssafy.happyhouse.model.dto.HouseDealDto;

@Service
public class HouseDealService {

	@Autowired
	private SqlSession sqlSession;
	
	public List<HouseDealDto> SimpleSearchHouse(String dong) {
		return sqlSession.getMapper(HouseDealMapper.class).SimpleSearchHouse(dong);
	}

	public HouseDealDto SearchHouse(String Aptname) {
		return sqlSession.getMapper(HouseDealMapper.class).SearchHouse(Aptname);
	}

	public List<HouseDealDto> getDealAvgBySido(String sidoName) {
		return sqlSession.getMapper(HouseDealMapper.class).getDealAvgBySido(sidoName);
	}
	
	public List<HouseDealDto> getDealCntByGugun(String gugunName){
		return sqlSession.getMapper(HouseDealMapper.class).getDealCntByGugun(gugunName);
	}
	
	public List<HouseDealDto> loadDealInfos() {
		return sqlSession.getMapper(HouseDealMapper.class).loadDealInfos();
	}
	
	public List<HouseDealDto> loadDealInfosWithDong(String dong) {
		return sqlSession.getMapper(HouseDealMapper.class).loadDealInfosWithDong(dong);
	}
	
	public HouseDealDto loadDealInfosWithDeal(String no) {
		return sqlSession.getMapper(HouseDealMapper.class).loadDealInfosWithDeal(no);
	}
		
	public int insertHouseDeal(HouseDealDto dto) {
		return sqlSession.getMapper(HouseDealMapper.class).insertHouseDeal(dto);
	}
	
	public List<HouseDealDto> selectByUserId(String useid){
		return sqlSession.getMapper(HouseDealMapper.class).selectByUserId(useid);
	}

	public int deleteMyDealByNo(int dealNo) {
		return sqlSession.getMapper(HouseDealMapper.class).deleteMyDealByNo(dealNo);		
	}
	
	public int deleteMyDealById(String userid) {
		return sqlSession.getMapper(HouseDealMapper.class).deleteMyDealById(userid);		
	}
	
	public String getTypeByNo(int dealno) {
		return sqlSession.getMapper(HouseDealMapper.class).getTypeByNo(dealno);
	}
	
	public List<HouseDealDto> search(String name) {
		return sqlSession.getMapper(HouseDealMapper.class).search(name);
	}
}
