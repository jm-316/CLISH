package com.itwillbs.clish.home.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.clish.admin.dto.CategoryDTO;
import com.itwillbs.clish.admin.service.CategoryService;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.home.service.MainService;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	private final CategoryService categoryService;
	private final MainService mainService;

	
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
	@GetMapping("/customer/announcements")
	public String announcements() {
		
		return "customer/announcements";
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
