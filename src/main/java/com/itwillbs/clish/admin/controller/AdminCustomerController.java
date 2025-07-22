package com.itwillbs.clish.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.clish.admin.dto.InquiryDTO;
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

	// 공지사항 리스트
	@GetMapping("/notice")
	public String notice(Model model) {
		List<SupportDTO> supportList = adminCustomerService.getNoticeList();
		
		model.addAttribute("supportList", supportList);
		
		return "/admin/customer/notice_list";
	}
	
	// 공지사항 등록
	@GetMapping("/notice/writeNotice")
	public String noticeWriteForm() {
		return "/admin/customer/notice_write_form";
	}
	
	// 공지사항 등록
	@PostMapping("/notice/writeNotice")
	public String noticeWrite(SupportDTO supportDTO) {
		adminCustomerService.registSupport(supportDTO);
		
		return "redirect:/admin/notice";
	}
	
	// 공지사항 상세
	@GetMapping("/notice/detail/{idx}")
	public String noticeDetailForm(@PathVariable("idx") String idx, Model model) {
		SupportDTO supportDTO = adminCustomerService.getSupport(idx);
		
		model.addAttribute("support", supportDTO);
		
		return "/admin/customer/notice_detail_form";
	}
	
	// 공지사항 수정
	@PostMapping("/notice/modify")
	public String noticeModify(SupportDTO supportDTO, Model model) {
		int update = adminCustomerService.modifySupport(supportDTO);
		
		if (update > 0) {
			model.addAttribute("msg", "공지사항을 수정했습니다.");
			model.addAttribute("targetURL", "/admin/notice");
		} else {
			model.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "commons/result_process";
	}
	
	// 공지사항 삭제
	@GetMapping("/notice/delete/{idx}")
	public String noticeDelete(@PathVariable("idx") String idx, RedirectAttributes rttr) {
		int delete = adminCustomerService.removeSupport(idx);
		
		if (delete > 0) {
			rttr.addFlashAttribute("msg", "공지사항을 삭제했습니다.");
		} else {
			rttr.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "redirect:/admin/notice";
	}
	
	@GetMapping("/faq")
	public String faqList(Model model) {
		List<SupportDTO> supportDTO = adminCustomerService.getFaqList();
		
		model.addAttribute("faqList", supportDTO);
		
		return "/admin/customer/faq_list";
	}
	
	@GetMapping("/faq/writeFaq")
	public String faqWriteForm() {
		return "/admin/customer/faq_write_form";
	}
	
	@PostMapping("/faq/writeFaq")
	public String faqWrite(SupportDTO supportDTO) {
		adminCustomerService.registSupport(supportDTO);
		
		return "redirect:/admin/faq";
	}
	
	
	// faq 상세
	@GetMapping("/faq/detail/{idx}")
	public String faqDetailForm(@PathVariable("idx") String idx, Model model) {
		SupportDTO supportDTO = adminCustomerService.getSupport(idx);
		
		model.addAttribute("support", supportDTO);
		
		return "/admin/customer/faq_detail_form";
	}
	
	// faq 수정
	@PostMapping("/faq/modify")
	public String faqModify(SupportDTO supportDTO, Model model) {
		int update = adminCustomerService.modifySupport(supportDTO);
		
		if (update > 0) {
			model.addAttribute("msg", "FAQ를 수정했습니다.");
			model.addAttribute("targetURL", "/admin/faq");
		} else {
			model.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "commons/result_process";
	}
	
	// faq 삭제
	@GetMapping("/faq/delete/{idx}")
	public String faqDelete(@PathVariable("idx") String idx, RedirectAttributes rttr) {
		int delete = adminCustomerService.removeSupport(idx);
		
		if (delete > 0) {
			rttr.addFlashAttribute("msg", "FAQ를 삭제했습니다.");
		} else {
			rttr.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "redirect:/admin/faq";
	}
	
	// 문의 리스트 
	@GetMapping("/inquiry")
	public String supportList(Model model) {
//		List<InquiryDTO> inquiryDTO = adminCustomerService.getInquiryList();
		List<Map<String, Object>> inquiryList = adminCustomerService.getInquiryList();
		
		model.addAttribute("inquiryList", inquiryList);
		
		return "/admin/customer/inquiry_list";
	}
}
