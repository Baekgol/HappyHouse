package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.model.dto.AddressDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;

public interface HouseMapper {
	public List<HouseInfoDto> getAptSearch(String search);
	public List<SidoGugunCodeDto> getSido();
	public List<SidoGugunCodeDto> getGugunInSido(String sido);
	public List<HouseInfoDto> getDongInGugun(String gugun);
	public List<HouseInfoDto> getAptInDong(String dong);
	public List<HouseInfoDto> loadHouseInfos();
	public AddressDto getAddress(String dong);
	public int insertHouseInfo(HouseInfoDto dto);
	public int isExistHouseInfo(@Param("lat")String lat, @Param("lng")String lng);
	public List<HouseInfoDto> searchName(String name);
}
