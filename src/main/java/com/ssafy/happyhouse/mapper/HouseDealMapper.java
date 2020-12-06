package com.ssafy.happyhouse.mapper;

import java.util.List;

import com.ssafy.happyhouse.model.dto.HouseDealDto;

public interface HouseDealMapper {
	public List<HouseDealDto> SimpleSearchHouse(String dong);
	public HouseDealDto SearchHouse(String Aptname);
	public List<HouseDealDto> getDealAvgBySido(String sidoName);
	public List<HouseDealDto> getDealCntByGugun(String gugunName);
	public List<HouseDealDto> loadDealInfos();
	public List<HouseDealDto> loadDealInfosWithDong(String dong);
	public HouseDealDto loadDealInfosWithDeal(String no);
	public int insertHouseDeal(HouseDealDto dto);
	public List<HouseDealDto> selectByUserId(String useid);
	public int deleteMyDealByNo(int dealNo);
	public int deleteMyDealById(String userid);
	public String getTypeByNo(int dealno);
	public List<HouseDealDto> search(String name);
}
