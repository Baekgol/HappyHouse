package com.ssafy.happyhouse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.service.DetailService;

@Controller
public class DetailController {
	@Autowired
	private DetailService service;
	
	@GetMapping("/detail")
	@ResponseBody
	public HouseDealDto postDetail(@RequestParam(value = "dealNo") int dealNo) {
		return service.SearchForDetail(dealNo);
	}

}