package com.ssafy.happyhouse.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.mapper.HouseMapper;
import com.ssafy.happyhouse.model.dto.AddressDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;

import java.util.List;

@Service
public class HouseService {
	@Autowired
	private SqlSession sqlSession;

	public List<SidoGugunCodeDto> getSido() throws Exception {
		return sqlSession.getMapper(HouseMapper.class).getSido();
	}

	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return sqlSession.getMapper(HouseMapper.class).getGugunInSido(sido);
	}

	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return sqlSession.getMapper(HouseMapper.class).getDongInGugun(gugun);
	}
	
	public List<HouseInfoDto> getAptInDong(String dong) throws Exception {
		return sqlSession.getMapper(HouseMapper.class).getAptInDong(dong);
	}
	
	public List<HouseInfoDto> getAptSearch(String search) throws Exception {
		return sqlSession.getMapper(HouseMapper.class).getAptSearch(search);
	}
	
	public List<HouseInfoDto> loadHouseInfos() {
		return sqlSession.getMapper(HouseMapper.class).loadHouseInfos(); 
	}
	
	public AddressDto getAddress(String dong) {
		return sqlSession.getMapper(HouseMapper.class).getAddress(dong); 
	}
	
	public int insertHouseInfo(HouseInfoDto dto) {
		return sqlSession.getMapper(HouseMapper.class).insertHouseInfo(dto);
	}
	
	public int isExistHouseInfo(String lat, String lng) {
		return sqlSession.getMapper(HouseMapper.class).isExistHouseInfo(lat, lng);
	}
	
	public List<HouseInfoDto> searchName(String name) {
		return sqlSession.getMapper(HouseMapper.class).searchName(name);
	}
}
