package com.ssafy.happyhouse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.ssafy.happyhouse.model.dto.MemberDto;
import com.ssafy.happyhouse.model.dto.NoticeDto;
import com.ssafy.happyhouse.model.dto.NoticePageDto;
import com.ssafy.happyhouse.model.service.NoticeService;

import javax.servlet.http.HttpSession;

@RequestMapping("/notice")
@Controller
public class NoticeController {
    @Autowired
    NoticeService noticeService;

    @GetMapping("/noticeList")
    public String getNotice(@RequestParam(value = "page", defaultValue = "1") int page, Model model, HttpSession httpSession) {

        MemberDto user = (MemberDto)httpSession.getAttribute("loginInfo");
        if (user==null) {
            return "login-error";
        }

        NoticePageDto pageDto = noticeService.makePage(page);
        model.addAttribute("pagDto", pageDto);

        return "notice";
    }

    @GetMapping("/info")
    public String getNoticeNum(@RequestParam(value = "num") int num, Model model) {
        NoticeDto notice = noticeService.findByNum(num);
        model.addAttribute("dto", notice);
        return "notice-info";
    }

    @GetMapping("/delete/{bnum}")
    public String deleteBnum(@PathVariable int bnum) {
        noticeService.delete(bnum);
        return "redirect:/notice/noticeList";
    }

    @GetMapping("/modify/{bnum}")
    public String getBnum(@PathVariable int bnum, Model model) {
        NoticeDto notice = noticeService.findByNum(bnum);
        model.addAttribute("dto", notice);
        return "notice-modify";
    }

    @PostMapping("/modify")
    public String putBnum(NoticeDto notice) {
        noticeService.update(notice);
        return "redirect:/notice/noticeList";
    }

    @GetMapping("/writer")
    public String getWriter() {
        return "notice-writer";
    }

    @PostMapping("/writer")
    public String postWriter(NoticeDto notice) {
        noticeService.save(notice);
        return "redirect:/notice/noticeList";
    }

}
