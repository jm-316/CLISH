package com.itwillbs.clish.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.clish.admin.dto.SupportDTO;
import com.itwillbs.clish.admin.service.AdminCustomerService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
@RequestMapping("admin")
@RequiredArgsConstructor
public class AdminCustomerController {
	private final AdminCustomerService adminCustomerService;

	@GetMapping("/notice")
	public String notice(Model model) {
		List<SupportDTO> supportList = adminCustomerService.getNoticeList();
		
		model.addAttribute("supportList", supportList);
		
		return "/admin/customer/notice_list";
	}
}
