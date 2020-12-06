package com.ssafy.happyhouse.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.mapper.DetailMapper;

@Service
public class DetailService {
	@Autowired
	private SqlSession sqlSession;
	
//	<select id="SearchForDetail" resultType="HouseDealDto" parameterType="String">
	public HouseDealDto SearchForDetail(int dealNo){
		return sqlSession.getMapper(DetailMapper.class).SearchForDetail(dealNo);
	}

}