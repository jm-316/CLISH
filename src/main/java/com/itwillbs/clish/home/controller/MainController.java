package com.itwillbs.clish.home.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.clish.admin.dto.CategoryDTO;
import com.itwillbs.clish.admin.dto.SupportDTO;
import com.itwillbs.clish.admin.service.AdminCustomerService;
import com.itwillbs.clish.admin.service.CategoryService;
import com.itwillbs.clish.common.dto.PageInfoDTO;
import com.itwillbs.clish.common.file.FileDTO;
import com.itwillbs.clish.common.file.FileMapper;
import com.itwillbs.clish.common.utils.PageUtil;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.home.service.MainService;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	private final CategoryService categoryService;
	private final MainService mainService;
	private final AdminCustomerService adminCustomerService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		List<CategoryDTO> parentCategories = categoryService.getCategoriesByDepth(1);
		List<CategoryDTO> childCategories = categoryService.getCategoriesByDepth(2);
		
		model.addAttribute("parentCategories", parentCategories);
		model.addAttribute("childCategories", childCategories);
		
		model.addAttribute("serverTime", formattedDate );
		List<ClassDTO> classList = mainService.getClassList();
		List<ClassDTO> classList2 = mainService.getClassList2();
		List<ClassDTO> classListLongLatest = mainService.getClassListLongLatest();
		List<ClassDTO> classListShortLatest = mainService.getClassListShortLatest();
		model.addAttribute("classList", classList);
		model.addAttribute("classList2", classList2);
		model.addAttribute("classListLongLatest", classListLongLatest);
		model.addAttribute("classListShortLatest", classListShortLatest);
		
//		return "home";
		return "main";
		
	}
	
	@GetMapping("/customer/customerCenter")
	public String notification() {
		
		return "customer/customer_center";
	}
	
	// 공지사항 리스트
	@GetMapping("/customer/announcements")
	public String announcements(Model model, @RequestParam(defaultValue = "1") int pageNum) {
		int listLimit = 5;
		int announcementCount = adminCustomerService.getAnnouncementCount();
		
		if (announcementCount > 0) {
			PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, announcementCount, pageNum, 3);
			
			if (pageNum < 1 || pageNum > pageInfoDTO.getMaxPage()) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "/customer/announcements");
				return "commons/result_process";
			}
			
			model.addAttribute("pageInfo", pageInfoDTO);
			
			List<SupportDTO> announcementList = adminCustomerService.getAnnouncementList(pageInfoDTO.getStartRow(), listLimit);
			model.addAttribute("announcementList", announcementList);
		}
		
		return "customer/announcements";
	}
	
	// 공지사항 작성 페이지
	@GetMapping("/customer/announcements/write")
	public String writeAnnouncementFrom() {
		return "customer/announcement_write_form";
	}
	
	// 공지사항 등록
	@PostMapping("/customer/announcements/write")
	public String writeAnnouncement(SupportDTO supportDTO) throws IllegalStateException, IOException {
		adminCustomerService.registSupport(supportDTO);
		
		return "redirect:/customer/announcements";
	}
	
	// 공지사항 상세페이지
	@GetMapping("/customer/announcement/detail/{idx}")
	public String announcementDetail(@PathVariable("idx") String idx, Model model) {
		SupportDTO supportDTO = adminCustomerService.getSupport(idx);
		
		model.addAttribute("announcement", supportDTO);
		
		return "customer/announcement_detail";
	}
	
	// 공지사항 수정페이지
	@GetMapping("/customer/announcement/modify/{idx}")
	public String modifyAnnouncementFrom(@PathVariable("idx") String idx, Model model) {
		SupportDTO supportDTO = adminCustomerService.getSupport(idx);
		model.addAttribute("announcement", supportDTO);
		
		return "customer/announcement_modify_form";
	}
	
	// 공지사항 수정
	@PostMapping("/customer/announcement/modify")
	public String modifyAnnouncement(SupportDTO supportDTO, Model model) throws IllegalStateException, IOException {
		int update = adminCustomerService.modifySupport(supportDTO);
		
		if (update > 0) {
			model.addAttribute("msg", "공지사항을 수정했습니다.");
			model.addAttribute("targetURL", "/customer/announcement/detail/" + supportDTO.getSupportIdx());
		} else {
			model.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "commons/result_process";
	}
	
	// 공지사항 삭제
	@GetMapping("/customer/announcement/delete/{idx}")
	public String deleteAnnouncement(@PathVariable("idx") String idx, RedirectAttributes rttr) {
		int delete = adminCustomerService.removeSupport(idx);
		
		if (delete > 0) {
			rttr.addFlashAttribute("msg", "공지사항을 삭제했습니다.");
		} else {
			rttr.addAttribute("msg", "다시 시도해주세요!");
			return "commons/fail";
		}
		
		return "redirect:/customer/announcements";
	}
	
	// 공지사항 파일 삭제
	@GetMapping("/customer/announcement/fileDelete")
	public String deleteFile(@RequestParam("supportIdx") String idx, FileDTO fileDTO) {
		adminCustomerService.removeFile(fileDTO);
		
		return "redirect:/customer/announcement/modify" + idx;
	}
	
	@GetMapping("/customer/FAQ")
	public String faq() {
		
		return "customer/FAQ";
	}
	@GetMapping("/customer/inquiry")
	public String inquiry() {
		
		return "customer/inquiry";
	}
	@GetMapping("/event/eventHome")
	public String eventHome() {
		
		return "event/event_home";
	}
	@GetMapping("/event/earlyDiscount")
	public String eventEarlyDiscount() {
		
		return "event/early_discount";
	}
	@GetMapping("/event/specialDiscount")
	public String eventSpecialDiscount() {
		
		return "event/special_discount";
	}
//	@GetMapping("/admin/main")
//	public String adminMain() {
//		
//		return "admin/user/admin_page";
//	}
	@GetMapping("/company/main")
	public String companyMain() {
		
		return "company/company_main";
	}
	@GetMapping("clish/myPage/main")
	public String myPageMain() {
		
		return "clish/myPage/myPage_main";
	}
	@GetMapping("/user/joinForm")
	public String userJoin() {
		
		return "user/join_form";
	}
	
	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

}
