package com.itwillbs.clish.home.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.clish.admin.dto.CategoryDTO;
import com.itwillbs.clish.admin.service.CategoryService;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MainController {
	private final CategoryService categoryService;
	
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
		
//		return "home";
		return "main";
		
	}

}
