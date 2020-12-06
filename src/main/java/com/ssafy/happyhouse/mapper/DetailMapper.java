package com.ssafy.happyhouse.mapper;

import com.ssafy.happyhouse.model.dto.HouseDealDto;

public interface DetailMapper {
	public HouseDealDto SearchForDetail(int dealNo);

}