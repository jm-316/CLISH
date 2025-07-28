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
import org.springframework.web.bind.annotation.ResponseBody;
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
		
		// 세션에서 userId 설정
	    user.setUserId((String) session.getAttribute("sId"));
	    
	    // DB에서 암호화된 비번 포함한 기업회원 정보 조회
	    user = companyInfoService.getUserInfo(user);
		

	    // 비밀번호 검증 (암호화된 비번 비교)
	    if (user != null && companyInfoService.matchesPassword(inputPw, user.getUserPassword())) {
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
	@PostMapping("/myPage/writeInquery")
	public String writeInquery(HttpSession session, InqueryDTO dto) {
		// 로그인 세션에서 user_id(hong)를 가져옴
	    String userId = (String) session.getAttribute("sId");
	    System.out.println("세션 userId: " + userId);
		
	    // user_id로 실제 user_idx 조회
	    String userIdx = companyInfoService.getUserIdxByUserId(userId);
	    System.out.println("조회한 userIdx: " + userIdx);
	    
	    // DTO에 user_idx 세팅
	    dto.setUserIdx(userIdx);
	    
		// inquery_idx 생성
		String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int random = new Random().nextInt(1000); // 0~999
		String inqueryIdx = String.format("INQ%s%03d", timestamp, random);
		dto.setInqueryIdx(inqueryIdx); // 직접 세팅
		
		
		companyInfoService.insertInquery(dto);
		return "redirect:/company/myPage/myQuestion";
	}
	
	// 문의 수정 폼
	@GetMapping("/myPage/modifyInquery")
	public String modifyInqueryForm(@RequestParam("inqueryIdx") String inqueryIdx, Model model) {
		
		// 파라미터로 전달받은 inqueryIdx를 이용해서 해당 문의 상세 정보를 조회
	    InqueryDTO dto = companyInfoService.getInqueryByIdx(inqueryIdx);
	    model.addAttribute("inqueryDTO", dto);
	    
	    return "/company/companyMyQuestionForm";
	}
	
	// 문의 수정버튼 로직
	@PostMapping("/myPage/modifyInquery")
	public String modifySubmit(InqueryDTO dto) {
		// 수정된 DTO 데이터를 서비스에 넘겨 DB 업데이트 수행
	    companyInfoService.updateInquery(dto);
	    
	    // 수정 후 문의 목록 페이지로 리다이렉트
	    return "redirect:/company/myPage/myQuestion";
	}
	
	// 문의 삭제 버튼 로직
	@PostMapping("/myPage/delete")
	public String deleteInquery(@RequestParam("inqueryIdx") String inqueryIdx) {
	    companyInfoService.deleteInquery(inqueryIdx);
	    return "redirect:/company/myPage/myQuestion";
	}
	// -----------------------------------------------------------------------------------------------------
	// 기업 회원 탈퇴
	@GetMapping("/myPage/withdraw")
	public String withdrawPage() {
	    return "/company/companyMypageWithdraw"; 
	}
	
	@PostMapping("/myPage/withdraw")
	public String withdrawForm(HttpSession session, UserDTO user, Model model) {
	    String userIdx = (String) session.getAttribute("sId");
	    user.setUserIdx(userIdx);

	    String inputPw = user.getUserPassword();

	    // DB에서 전체 유저 정보 불러오기
	    user = companyInfoService.getUserInfo(user);

	    if (user != null && user.getUserPassword().equals(inputPw)) {
	        return "company/companyMypageWithdrawResult";
	    } else {
	        model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
	        return "commons/fail";
	    }
	    
	}
	
	@PostMapping("/myPage/withdrawFinal")
	public String withdrawFinal(HttpSession session, Model model) {
	    String userIdx = (String) session.getAttribute("sId");

	    UserDTO user = new UserDTO();
	    user.setUserIdx(userIdx);

	    int result = companyInfoService.withdraw(user);

	    if (result > 0) {
	        session.invalidate(); // 세션 만료
	        model.addAttribute("msg", "탈퇴완료");
	    } else {
	    	 model.addAttribute("msg", "탈퇴실패");
	    }
	    
	    return "company/companyMypageWithdrawResult";
	}
}










