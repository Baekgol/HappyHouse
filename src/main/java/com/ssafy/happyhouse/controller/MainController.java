package com.ssafy.happyhouse.controller;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ssafy.happyhouse.model.dto.MemberDto;
import com.ssafy.happyhouse.model.dto.NoticePageDto;
import com.ssafy.happyhouse.model.service.NewsService;
import com.ssafy.happyhouse.model.service.NoticeService;

@Controller
public class MainController {
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private NewsService newsService; 
	
	@GetMapping("/")
	public String getNewsIndex(String keyword, HttpSession session, Model model) throws ParseException {
		session.setAttribute("noticeList", noticeService.makePage(1).getNoticeList());
					
		if(session.getAttribute("newsList")==null)
			session.setAttribute("newsList", newsService.getNews(keyword, 5));
		
		return "index";
	}
	
	@GetMapping("/house")
	public String houseSearch(HttpSession session) {
		MemberDto user = (MemberDto)session.getAttribute("loginInfo");
		if (user==null) return "login-error";
		return "houseSearch";
	}
}
