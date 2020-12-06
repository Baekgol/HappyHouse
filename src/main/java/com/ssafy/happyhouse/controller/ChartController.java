package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.MemberDto;
import com.ssafy.happyhouse.model.service.HouseDealService;

@Controller
public class ChartController {

	@Autowired
	private HouseDealService dealService;
	
	
	@GetMapping("/avgdata")
	@ResponseBody
	public String getAvgChart(Model model, HttpSession session) {
		MemberDto dto = (MemberDto) session.getAttribute("loginInfo");
		
		if(dto!=null) {
			Gson gson = new Gson();
			List<HouseDealDto> list = dealService.getDealAvgBySido(dto.getSido());
			return gson.toJson(list);
		}
		return "";
	}
	
	@GetMapping("/cntdata")
	@ResponseBody
	public String getCntChart(Model model, HttpSession session) {
		MemberDto dto = (MemberDto) session.getAttribute("loginInfo");
		
		if(dto!=null) {
			Gson gson = new Gson();
			List<HouseDealDto> list = dealService.getDealCntByGugun(dto.getGugun());
			return gson.toJson(list);
		}
		return "";
	}

}
