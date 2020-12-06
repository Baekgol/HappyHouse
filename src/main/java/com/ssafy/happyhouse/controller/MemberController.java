package com.ssafy.happyhouse.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.dto.MemberDto;
import com.ssafy.happyhouse.model.dto.RegisterDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.InterestService;
import com.ssafy.happyhouse.model.service.MemberService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@CrossOrigin(origins = "*")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	InterestService interestService;

	@GetMapping("/login")
	public String getLogin() {
		return "login";
	}

	@GetMapping("/register")
	public String getRegister() {
		return "register";
	}

	@PostMapping("/login")
	public String postLogin(MemberDto member, HttpSession httpSession, Model model) {
		String userid = member.getUserid();
		MemberDto findMember = memberService.findById(userid);
		if (findMember == null) {
			model.addAttribute("errorMsg", "아이디 혹은 비밀번호를 확인하세요.");
			return "login";
		}
		String pwd = member.getUserpwd();
		String findPwd = findMember.getUserpwd();
		
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		if(!encoder.matches(pwd, findPwd)) {
			model.addAttribute("errorMsg", "아이디 혹은 비밀번호를 확인하세요.");
			return "login";
		}

		httpSession.setAttribute("loginInfo", findMember);
		return "redirect:/";
	} 
	
	@PostMapping("/register")
	public String postRegister(RegisterDto register, Model model) {
		String userid = register.getUserid();
		SidoGugunCodeDto sidoDto = memberService.getSidoName(Integer.parseInt(register.getSido()));
		String gugun = register.getGugun();
		
		if(sidoDto==null) {
			model.addAttribute("errorMsg", "시도를 선택해주세요.");
			return "register";
		}
		else {
			MemberDto member = memberService.findById(userid);
			if (member == null) {
				String pw = register.getUserpwd();
				String confirm = register.getConfirm();
				if (memberService.checkPwd(pw, confirm)) {
					if(gugun.equals("구군") || gugun.equals("선택")) {
						model.addAttribute("errorMsg", "구군을 선택해주세요.");
						return "register";
					}
					
					register.setSido(sidoDto.getSidoName());
					
					// 비밀번호 암호화
					PasswordEncoder encoder = new BCryptPasswordEncoder();
					String encodePassword = encoder.encode(pw);
			        register.setUserpwd(encodePassword);
					
					memberService.save(register.toMember());
					return "login";
				} else {
					model.addAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
					return "register";
				}
			}
		}
		
		model.addAttribute("errorMsg", "이미 존재하는 아이디입니다.");
		return "register";
	}

	@GetMapping("/member/find/{userid}")
	public String getMemberUserId(@PathVariable String userid, Model model) {
		MemberDto member = memberService.findById(userid);
		model.addAttribute("member", member);
		return "memberInfo";
	}

	@PostMapping("/member/modify")
	public String memberModify(HttpSession session, MemberDto member) {
		SidoGugunCodeDto sidoDto = memberService.getSidoName(Integer.parseInt(member.getSido()));
		member.setSido(sidoDto.getSidoName());
		String newPwd = member.getUserid();
		
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		String encodePassword = encoder.encode(member.getUserpwd());
        member.setUserpwd(encodePassword);
		
		memberService.updateMember(member);
		session.setAttribute("loginInfo", memberService.findById(member.getUserid()));
		return "redirect:/";
	}

	@GetMapping("/member/delete/{userid}")
	public String deleteMember(@PathVariable String userid, HttpSession httpSession) {
		memberService.delete(userid);
		interestService.ifDeleteUser(userid);
		httpSession.invalidate();
		return "index";
	}

	@GetMapping("/member/password")
	public String getMemberPassword() {
		return "password";
	}

	@PostMapping("/member/password")
	public String postMemberPassword(@RequestParam String userid, Model model) {
		MemberDto member = memberService.findById(userid);
		if (member == null) {
			model.addAttribute("errorMsg", "해당 아이디의 유저가 없습니다.");
		} else {
			model.addAttribute("successMsg", member.getUserpwd());
		}
		return "password";
	}

	@GetMapping("/admin")
	public String getAdmin(Model model, HttpSession httpSession) {
		MemberDto dto = (MemberDto) httpSession.getAttribute("loginInfo");
		boolean check = dto.getAdmin();
		if (!check) {
			return "index";
		}
		
		List<MemberDto> members = memberService.findAll();
		model.addAttribute("members", members);
		
//		List<MemberDto> lamda = members.stream().filter(member->{
//			if(member.getAdmin()) {
//				return false;
//			}
//            return true;
//        }).collect(Collectors.toList());
//
//		model.addAttribute("members", lamda);

		return "admin";
	}

	@GetMapping("/admin/delete/{userid}")
	public String deleteUser(@PathVariable String userid, HttpSession httpSession) {
		MemberDto check = (MemberDto) httpSession.getAttribute("loginInfo");
		if (!check.getAdmin()) return "index";
		memberService.delete(userid);
		return "redirect:/admin";
	}

}
