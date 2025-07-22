package com.itwillbs.clish.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@GetMapping("/writeNotice")
	public String writeForm() {
		return "/admin/customer/notice_write_form";
	}
	
	@PostMapping("/writeNotice")
	public String write(SupportDTO supportDTO) {
		adminCustomerService.registNotice(supportDTO);
		
		return "redirect:/admin/notice";
	}
	
	@GetMapping("/detail/{idx}")
	public String detailForm(@PathVariable("idx") String idx, Model model) {
		SupportDTO supportDTO = adminCustomerService.getNotice(idx);
		
		model.addAttribute("support", supportDTO);
		
		return "/admin/customer/notice_detail_form";
	}
	
	@PostMapping("/modify")
	public String modify(SupportDTO supportDTO, Model model) {
		int update = adminCustomerService.modifyNotice(supportDTO);
		
		if (update > 0) {
			model.addAttribute("msg", "공지사항을 수정했습니다.");
			model.addAttribute("targetURL", "/admin/notice");
		} else {
			model.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "commons/result_process";
	}
	
	@GetMapping("/delete/{idx}")
	public String delete(@PathVariable("idx") String idx, RedirectAttributes rttr) {
		int delete = adminCustomerService.removeNotice(idx);
		
		if (delete > 0) {
			rttr.addAttribute("msg", "공지사항을 삭제했습니다.");
		} else {
			rttr.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "redirect:/admin/notice";
	}
}
