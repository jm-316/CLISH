package com.itwillbs.clish.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.clish.admin.dto.CategoryRevenueDTO;
import com.itwillbs.clish.admin.dto.DashboardSummaryDTO;
import com.itwillbs.clish.admin.dto.RevenueDTO;
import com.itwillbs.clish.admin.service.AdminDashboardService;
import com.itwillbs.clish.admin.service.AdminUserService;
import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("admin")
@RequiredArgsConstructor
public class AdminUserController {
	private final AdminUserService adminService;
	private final AdminDashboardService adminDashboardService;
	
	@GetMapping("/main")
	public String adminIndex(DashboardSummaryDTO summaryDTO, Model model) {
		adminDashboardService.getSummary(summaryDTO);
		
		List<RevenueDTO> dailyList = adminDashboardService.getDailyRevenue();
		List<RevenueDTO> weeklyList  = adminDashboardService.getMonthlyRevenue();
		
		model.addAttribute("summary", summaryDTO);
		model.addAttribute("dailyList", dailyList);
		model.addAttribute("weeklyList", weeklyList);

		return "/admin/admin_page";
	}
	
	@GetMapping("/revenue/daily")
	@ResponseBody
	public List<RevenueDTO> getDailyRevenue() {
		return adminDashboardService.getDailyRevenue();
	}
	
	@GetMapping("/revenue/monthly")
	@ResponseBody
	public List<RevenueDTO> getMonthlyRevenue() {
		return adminDashboardService.getMonthlyRevenue();
	}
	
	@GetMapping("/revenue/category")
	@ResponseBody
	public List<CategoryRevenueDTO> getCategoryRevenue() {
		return adminDashboardService.getCategoryRevenue();
	}
	
	// 일반 회원 정보 리스트
	@GetMapping("/user")
	public String userList(Model model) {
		List<UserDTO> userList = adminService.getUserList();
		
		model.addAttribute("users", userList);
		
		return "/admin/user/user_list";
	}
	
	// 일반 회원 상세 정보
	@GetMapping("/user/{idx}")
	public String userInfo(@PathVariable("idx") String idx, Model model) {
		UserDTO userInfo = adminService.getuserInfo(idx);
		String phone = masktedPhone(userInfo.getUserPhoneNumber());
		String phoneSub = masktedPhone(userInfo.getUserPhoneNumberSub());
		
		model.addAttribute("user", userInfo);
		model.addAttribute("phone", phone);
		model.addAttribute("phoneSub", phoneSub);
		return "/admin/user/user_info";
	}
	
	private String masktedPhone(String phone) {
		String maskedPhone = "";
		if (phone != null && phone.length() == 11) {
		    maskedPhone = phone.substring(0, 3) + "-" +
		                  phone.substring(3, 7) + "-" +
		                  "****";
		} else {
		    maskedPhone = "잘못된 번호";
		}
		
		return maskedPhone;
	}
	
	
	// 일반 회원 탈퇴처리
	@PostMapping("/user/{idx}/withdraw")
	public String userWithdraw(@PathVariable("idx") String idx, Model model) {
		int count = adminService.setUserStatus(idx, 3);
		
		if (count > 0) {
			model.addAttribute("msg", "탈퇴를 처리했습니다.");
			model.addAttribute("targetURL", "/admin/user");
		} else {
			model.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "commons/result_process";
	}
	
	
	// 기업 정보 리스트
	@GetMapping("/company")
	public String companyList(Model model) {
		List<UserDTO> companyList = adminService.getCompanyList();
		
		model.addAttribute("companys", companyList);
		
		return "/admin/user/company_list";
	}
	
	// 기업 상세 정보
	@GetMapping("/company/{idx}")
	public String companyInfo(@PathVariable("idx") String idx, Model model) {
		UserDTO companyInfo = adminService.getcompanyInfo(idx);
		CompanyDTO comDto = adminService.getCompanyBizReg(idx);
		
		String phone = masktedPhone(companyInfo.getUserPhoneNumber());
		String phoneSub = masktedPhone(companyInfo.getUserPhoneNumberSub());
		
		model.addAttribute("company", companyInfo);
		model.addAttribute("phone", phone);
		model.addAttribute("phoneSub", phoneSub);
		model.addAttribute("comDto", comDto);
		
		return "/admin/user/company_info";
	}
	
	// 기업 승인
	@PostMapping("/company/{idx}/approve")
	public String approveCompany(@PathVariable("idx") String idx, Model model) {
		int success = adminService.modifyStatus(idx, 1);
		
		if (success > 0) {
			model.addAttribute("msg", "승인 완료되었습니다.");
			model.addAttribute("targetURL", "/admin/company");
		} else {
			model.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "commons/result_process";
	}
	
	// 기업 승인취소
	@PostMapping("/company/{idx}/cancelApproval")
	public String cancelApproveCompany(@PathVariable("idx") String idx, Model model) {
		int success = adminService.modifyStatus(idx, 5);
		
		if (success > 0) {
			model.addAttribute("msg", "승인 취소 되었습니다.");
			model.addAttribute("targetURL", "/admin/company");
		} else {
			model.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "commons/result_process";
	}
	
	// 일반 회원 탈퇴처리
	@PostMapping("/company/{idx}/withdraw")
	public String companyWithdraw(@PathVariable("idx") String idx, Model model) {
		int count = adminService.modifyStatus(idx, 3);
		
		if (count > 0) {
			model.addAttribute("msg", "탈퇴를 처리했습니다.");
			model.addAttribute("targetURL", "/admin/company");
		} else {
			model.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "commons/result_process";
	}
	
	
}
