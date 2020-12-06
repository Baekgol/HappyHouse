package com.ssafy.happyhouse.controller;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ssafy.happyhouse.model.service.NewsService;

@Controller
public class NewsController {
	@Autowired
	private NewsService service; 
	
	@GetMapping("/news")
	public String getNews(String keyword, Model model) throws ParseException {
		model.addAttribute("newsList", service.getNews(keyword,10));	// 뉴스 다섯개만 가져올거임
		return "news";
	}
}
