package com.ssafy.happyhouse.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.mapper.HouseDealMapper;
import com.ssafy.happyhouse.model.dto.MemberDto;
import com.ssafy.happyhouse.model.dto.QnaDto;
import com.ssafy.happyhouse.model.dto.QnaPageDto;
import com.ssafy.happyhouse.model.service.HouseDealService;
import com.ssafy.happyhouse.model.service.QnaService;


@Controller
@CrossOrigin(origins = "*")
public class QnaController {
	@Autowired
	private QnaService service;
	
	@Autowired
	private HouseDealService dealService;
	
	@GetMapping("/qna")
	public String qna() {
    	return "qna"; 
    }
	
    @GetMapping("/qnaList")
    public String getQna(@RequestParam(value = "page", defaultValue = "1") int page, 
    		int dealno, Model model, HttpSession httpSession) {

        MemberDto user = (MemberDto)httpSession.getAttribute("loginInfo");
        if (user==null) {
            return "login-error";
        }

        QnaPageDto pageDto = service.makePage(page, dealno);
        model.addAttribute("pagDto", pageDto);
        model.addAttribute("dealno", dealno);
        model.addAttribute("type", dealService.getTypeByNo(dealno));
        
        return "qna/qnaList";
    }

	
	@GetMapping("/qnaDetail/{id}")
	public String getDetail(@PathVariable("id") int id, Model model) {
		QnaDto dto = service.searchOne(id); 
		model.addAttribute("dto", dto);
		return "qna/qnaDetail";
	}
	
	@PostMapping("/qnaAdd")
	@ResponseBody
	public void postRegistQna(QnaDto dto) {
		service.insertQna(dto);
		return;
	}
	
	@PostMapping("/ansUpdate")
	@ResponseBody
	public void postUpdateAns(QnaDto dto) {
		service.updateAns(dto);
		return;	
	}
	
	
	@PostMapping("/qnaUpdate")
	public int postUpdateQna(@RequestBody QnaDto dto) {
		return service.updateQna(dto);
	}
	
	
	
	@DeleteMapping("/qnaDetail/{id}")
	public int deleteQna(@PathVariable("id") int id) {
		return service.deleteQna(id);
	}
	
}
