package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.mapper.InterestMapper;
import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.InterestDto;

@Service
public class InterestService {
	@Autowired
	private SqlSession sqlSession;
	
	public List<HouseDealDto> searchAll(String userid){
		return sqlSession.getMapper(InterestMapper.class).searchAll(userid);
	}
	
	public int insertInterest(InterestDto dto) {
		return sqlSession.getMapper(InterestMapper.class).insertInterest(dto);
	}
	
	public int deleteInterest(InterestDto dto) {
		return sqlSession.getMapper(InterestMapper.class).deleteInterest(dto);
	}
	
	public int ifDeleteUser(String userid) {
		return sqlSession.getMapper(InterestMapper.class).ifDeleteUser(userid);
	}
	
	public List<InterestDto> myInterest(String userid){
        return sqlSession.getMapper(InterestMapper.class).myInterest(userid);
    }
}
