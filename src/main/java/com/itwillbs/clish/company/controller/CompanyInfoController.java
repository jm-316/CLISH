package com.itwillbs.clish.company.controller;

import java.util.List;
import java.text.SimpleDateFormat;  // ← 날짜 포맷용
import java.util.Date;              // ← 시간 객체
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.clish.admin.dto.InquiryJoinUserDTO;
import com.itwillbs.clish.company.service.CompanyInfoService;
import com.itwillbs.clish.course.service.CompanyClassService;
import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/company")
@RequiredArgsConstructor
public class CompanyInfoController {
	private final CompanyInfoService companyInfoService;
	
	// 정보 수정 전 비밀번호 확인페이지
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
	// ------------------------------------------------------------------------------------------------------------------
	
	// 기업 - 나의 문의 목록(리스트) 조회
	@GetMapping("/myPage/myQuestion")
	public String showInquiryForm(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("sId"); 
        
		// ① userId가 "hong"일 경우, user_idx로 변환하는 작업이 필요
		String userIdx = companyInfoService.getUserIdxByUserId(userId); 
	    List<InquiryJoinUserDTO> inquiryList = companyInfoService.getInquiriesByUserIdx(userIdx);
	    model.addAttribute("test", inquiryList);
//	    model.addAttribute("inquiryList1", inquiryList);
	    
	    System.out.println("inquiryList = " + inquiryList);

        return "company/companyMyQuestion"; 
    }
	
	
	// 문의 등록 폼
	@GetMapping("/myPage/writeInquery")
	public String goWriteInquery(Model model) {
	    // 등록 폼이니까 비어있는 inqueryDTO 넘겨도 됨
	    model.addAttribute("inqueryDTO", null); 
	    return "/company/companyMyQuestionForm";
	}
	
	// 문의 등록버튼 로직
	@PostMapping("/myPage/insertInquery")
	public String insertInquery(HttpSession session, InqueryDTO dto) {
		// 1. 로그인 세션에서 user_id(hong)를 가져옴
	    String userId = (String) session.getAttribute("sId");
	    System.out.println("세션 userId: " + userId);
		
	    // 2. user_id로 실제 user_idx 조회
	    String userIdx = companyInfoService.getUserIdxByUserId(userId);
	    System.out.println("조회한 userIdx: " + userIdx);
	    
	    // 3. DTO에 user_idx 세팅
	    dto.setUserIdx(userIdx);
	    
		// inquery_idx 생성
		String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int random = new Random().nextInt(1000); // 0~999
		String inqueryIdx = String.format("INQ%s%03d", timestamp, random);
		dto.setInqueryIdx(inqueryIdx); // 직접 세팅
		
		
		companyInfoService.insertInquery(dto);
		return "redirect:/company/myPage/myQuestion";
	}
}