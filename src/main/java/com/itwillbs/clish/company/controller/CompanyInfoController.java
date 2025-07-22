package com.itwillbs.clish.company.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.clish.company.service.CompanyInfoService;
import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/company")
@RequiredArgsConstructor
public class CompanyInfoController {
	private final CompanyInfoService companyInfoService;
	
	@GetMapping("/myPage/companyCheckPw")
	public String companyCheckPwForm(HttpSession session) {
		return "company/companyCheckPw";
	}
	
	// 비밀번호 확인 일치시 수정페이지로 불일치시 비밀번호가 틀렸습니다 메시지
	@PostMapping("/myPage/companyInfo")
	public String companyInfoForm(UserDTO user, HttpSession session, Model model) {
		// 로그인한 기업회원 정보 조회
		String inputPw = user.getUserPassword();
		
	    user.setUserId((String) session.getAttribute("sId"));
	    user = companyInfoService.getUserInfo(user);

	    if (user != null && user.getUserPassword().equals(inputPw)) {
	        model.addAttribute("user", user);
	        return "company/companyInfo"; 
	    }
	    
	    System.out.println("입력된 비번: " + inputPw);
	    System.out.println("DB에서 조회한 비번: " + user.getUserPassword());
	    
	    model.addAttribute("msg", "비밀번호가 틀렸습니다.");
	    model.addAttribute("targetUrl", "/company/myPage/companyCheckPw");
	    return "commons/result_process";
	}
	
	// 수정정보 UPDATE문 으로 반영 후 메인페이지로 이동
	@PostMapping("/myPage/companyInfoSubmit")
	public String companyInfoSubmit(UserDTO user, CompanyDTO company,
			HttpSession session, @RequestParam("userPasswordConfirm") String new_password) {
		user.setUserId((String)session.getAttribute("sId"));
		
		UserDTO user1 = companyInfoService.getUserInfo(user); // 기존 유저 정보 불러오기

		if(!user1.getUserEmail().equals(user.getUserEmail())){
			user.setNewEmail(user.getUserEmail());
		}
		
		if(!new_password.isEmpty()) { // 새비밀번호가 있다면 비밀번호 새로지정
			user.setUserPassword(new_password);
		}else { // 아니면 기존 비밀번호 유지
			user.setUserPassword(user1.getUserPassword());
		}
		
		company.setUserIdx(user1.getUserIdx());
				
		companyInfoService.setUserInfo(user);
		companyInfoService.setCompanyInfo(company); 
		
		return "redirect:/company";
	}
	
	
}
