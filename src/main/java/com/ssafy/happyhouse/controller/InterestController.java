package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.InterestDto;
import com.ssafy.happyhouse.model.dto.MemberDto;
import com.ssafy.happyhouse.model.service.InterestService;

@Controller
public class InterestController {
	@Autowired
	private InterestService service;
	
	@GetMapping("/myInterest")
	@ResponseBody
	public List<InterestDto> myInterest(HttpSession httpSession) {
	    MemberDto dto = (MemberDto) httpSession.getAttribute("loginInfo");
	    String userid = dto.getUserid();
	    List<InterestDto> myList = service.myInterest(userid);
	    
	    return myList;
	}
	
	@GetMapping("/interestList")
	public String getInterest(Model model, HttpSession httpSession) {
		MemberDto dto = (MemberDto) httpSession.getAttribute("loginInfo");
        if (dto == null) {
            return "plzLogin";
        }
        List<HouseDealDto> list = service.searchAll(dto.getUserid());

        model.addAttribute("interestList", list);
		
        return "interest";
	}
	
	@PostMapping("/insertInterest")
    @ResponseBody
    public int insertInterest(@RequestParam(value = "dealNo") int dealNo, HttpSession httpSession) {
        InterestDto dto = new InterestDto();
        
        int myNo = dealNo;
        MemberDto idDto = (MemberDto) httpSession.getAttribute("loginInfo");
        String myId = idDto.getUserid();
        
        dto.setDealno(myNo);
        dto.setUserid(myId);
        
        service.insertInterest(dto);
        
        return myNo;
    }
	
	@PostMapping("/deleteInterest")
	@ResponseBody
	public int deleteInterest(@RequestParam(value = "dealNo") int dealNo, HttpSession httpSession) {
	    InterestDto dto = new InterestDto();
	    
	    int myNo = dealNo;
	    MemberDto idDto = (MemberDto) httpSession.getAttribute("loginInfo");
	    String myId = idDto.getUserid();
	    
	    dto.setDealno(myNo);
	    dto.setUserid(myId);
	    
	    service.deleteInterest(dto);
	    
	    return myNo;
	}
}
