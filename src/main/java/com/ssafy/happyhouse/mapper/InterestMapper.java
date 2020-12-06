package com.ssafy.happyhouse.mapper;

import java.util.List;

import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.InterestDto;

public interface InterestMapper {
	public List<HouseDealDto> searchAll(String userid);
	public int insertInterest(InterestDto dto);
	public int deleteInterest(InterestDto dto);
	public int ifDeleteUser(String userid);
	public List<InterestDto> myInterest(String userid);
}
