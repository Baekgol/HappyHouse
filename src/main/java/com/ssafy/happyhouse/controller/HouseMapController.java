package com.ssafy.happyhouse.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.dto.AddressDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.HouseDealService;
import com.ssafy.happyhouse.model.service.HouseService;

@Controller
@RequestMapping("/map")
public class HouseMapController {
	@Autowired
	private HouseService mapService;
	
	@Autowired
	private HouseService houseService;
	
	@Autowired
	private HouseDealService houseDealService;

	@GetMapping("/sido")
	@ResponseBody
	public List<SidoGugunCodeDto> getSido() throws Exception{
		return mapService.getSido();
	}
	
	@GetMapping("/gugun")
	@ResponseBody
	public List<SidoGugunCodeDto> getGugun(String sido) throws Exception{
		return mapService.getGugunInSido(sido);
	}
	
	@GetMapping("/dong")
	@ResponseBody
	public List<HouseInfoDto> getDong(String gugun) throws Exception{
		return mapService.getDongInGugun(gugun);
	}
	
	@GetMapping("/loadHouseInfos")
	@ResponseBody
	public List<HouseInfoDto> loadHouseInfos() {
		return houseService.loadHouseInfos();
	}
	
	@GetMapping("/loadDealInfos")
	@ResponseBody
	public List<HouseDealDto> loadDealInfos() {
		return houseDealService.loadDealInfos();
	}
	
	@GetMapping("/loadDealInfos/dong/{dong}")
	@ResponseBody
	public List<HouseDealDto> loadDealInfosWithDong(@PathVariable("dong") String dong) {
		return houseDealService.loadDealInfosWithDong(dong);
	}
	
	@GetMapping("/loadDealInfos/deal/{dealList}")
	@ResponseBody
	public List<HouseDealDto> loadDealInfosWithDeal(@PathVariable("dealList") List<String> dealList) {
		List<HouseDealDto> result = new ArrayList<>();
		for(String deal: dealList)
			result.add(houseDealService.loadDealInfosWithDeal(deal));
		return result;
	}
	
	@GetMapping("/address/{dong}")
	@ResponseBody
	public AddressDto getAddress(@PathVariable("dong") String dong) {
		return houseService.getAddress(dong);
	}
	
	@GetMapping("/searchName/{name}")
	@ResponseBody
	public List<HouseInfoDto> searchName(@PathVariable("name") String name) {
		return houseService.searchName(name);
	}
	
	@GetMapping("/search/{name}")
	@ResponseBody
	public List<HouseDealDto> search(@PathVariable("name") String name) {
		return houseDealService.search(name);
	}
}