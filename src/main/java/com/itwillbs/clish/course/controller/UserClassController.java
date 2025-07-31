package com.itwillbs.clish.course.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.clish.admin.controller.AdminUserController;
import com.itwillbs.clish.admin.dto.CategoryDTO;
import com.itwillbs.clish.admin.service.AdminClassService;
import com.itwillbs.clish.admin.service.AdminUserService;
import com.itwillbs.clish.admin.service.CategoryService;
import com.itwillbs.clish.common.dto.PageInfoDTO;
import com.itwillbs.clish.common.utils.PageUtil;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.course.dto.CurriculumDTO;
import com.itwillbs.clish.course.service.CompanyClassService;
import com.itwillbs.clish.course.service.CurriculumService;
import com.itwillbs.clish.course.service.UserClassService;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.myPage.dto.ReviewDTO;
import com.itwillbs.clish.user.dto.UserDTO;
import com.itwillbs.clish.user.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/course")
@RequiredArgsConstructor
public class UserClassController {
	private final CompanyClassService companyClassService;
	private final UserClassService userClassService;
	private final CategoryService categoryService;
	private final UserService userService;
	private final CurriculumService curriculumService;
	
	// 클래스 리스트
	@GetMapping("/user/classList")
	public String classListForm(Model model, HttpSession session,
			@RequestParam int classType,
			@RequestParam(required = false)String categoryIdx) {
		
		// session 객체에 있는 userId 저장
		String userId = (String)session.getAttribute("sId");
		UserDTO user = userService.selectUserId(userId);
		
		List<ClassDTO> classList = userClassService.getClassList(classType, categoryIdx);
		
		model.addAttribute("classList", classList);
		model.addAttribute("user", user);
		
		return "/course/user/course_list";
	}
	
	// 클래스 상세 페이지
	@GetMapping("/user/classDetail")
	public String classDetailForm(@RequestParam String classIdx, Model model, HttpSession session,
			@RequestParam int classType,
			@RequestParam(required = false)String categoryIdx,
			@RequestParam(defaultValue = "1") int reviewPageNum) {
		
		String userId = (String)session.getAttribute("sId");
		UserDTO user = userService.selectUserId(userId);
		ClassDTO classInfo = companyClassService.getClassInfo(classIdx);
		
		List<CurriculumDTO> curriculumList = curriculumService.getCurriculumList(classIdx);
		
		int listLimit = 2;
		int reviewListCount = userClassService.getClassReviewCount(classIdx);
		
		if(reviewListCount > 0) {
			PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, reviewListCount, reviewPageNum, 3);
			if(reviewPageNum < 1 || reviewPageNum > pageInfoDTO.getMaxPage()) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "/myPage/myReview"); 
				return "commons/result_process";
			}
			
			model.addAttribute("pageInfo", pageInfoDTO);
			
			List<ReviewDTO> reviewList = userClassService.getClassReview(pageInfoDTO.getStartRow(), listLimit, classIdx);
			
			model.addAttribute("reviewList", reviewList);
		}
		
		model.addAttribute("classInfo", classInfo);
		model.addAttribute("user", user);
		model.addAttribute("curriculumList", curriculumList);
		
		return "/course/user/course_detail";
	}
	
	// 예약정보 입력 페이지
	@GetMapping("/user/classReservation")
	public String classReservation(@RequestParam String classIdx, Model model, HttpSession session, 
			ClassDTO classDTO, UserDTO userDTO, ReservationDTO reservationDTO,
			@RequestParam int classType,
			@RequestParam(required = false)String categoryIdx,
			@RequestParam(defaultValue = "1") int reviewPageNum) {
		
		String userId = (String)session.getAttribute("sId");
		UserDTO userInfo = userClassService.getUserIdx(userId); 
		String userIdx = userInfo.getUserIdx(); // userIdx
		ClassDTO classInfo = companyClassService.getClassInfo(classIdx); // classIdx
		
		List<CurriculumDTO> curriculumList = curriculumService.getCurriculumList(classIdx);
		
		int listLimit = 2;
		int reviewListCount = userClassService.getClassReviewCount(classIdx);
		
		if(reviewListCount > 0) {
			PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, reviewListCount, reviewPageNum, 3);
			if(reviewPageNum < 1 || reviewPageNum > pageInfoDTO.getMaxPage()) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "/myPage/myReview"); 
				return "commons/result_process";
			}
			
			model.addAttribute("pageInfo", pageInfoDTO);
			
			List<ReviewDTO> reviewList = userClassService.getClassReview(pageInfoDTO.getStartRow(), listLimit, classIdx);
			
			model.addAttribute("reviewList", reviewList);
		}
		
		reservationDTO.setClassIdx(classIdx);
		reservationDTO.setUserIdx(userIdx);
		
		model.addAttribute("classInfo", classInfo);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("curriculumList", curriculumList);
		
		return "/course/user/course_reservation";
	}
	
	// 예약 정보 INSERT 및 myPage 이동
	@GetMapping("/user/reservationInfo")
	public String classReservationSuccess(Model model, HttpSession session, ReservationDTO reservationDTO, ClassDTO classDTO,
			@RequestParam("reservationClassDateRe")@DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
		
		// 허용된 날짜 리스트
		classDTO = companyClassService.getClassInfo(classDTO.getClassIdx());
	    LocalDate startDate = classDTO.getStartDate();
	    LocalDate endDate   = classDTO.getEndDate();

	    // 유효 날짜인지 검사 
	    if (date.isBefore(startDate) || date.isAfter(endDate)) {
	        model.addAttribute("error", "선택할 수 없는 날짜입니다.");
	        return "reservation_form";
	    }
		
	    // 가능 인원인지 검사
	    
	    
	    // LocalDate → LocalDateTime 변환 (시간을 00:00:00 으로 세팅)
	    LocalDateTime localDateTime = date.atStartOfDay();
		
		// reservationIdx 생성
		String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
		String reservationIdx = "RE" + now;
		
		reservationDTO.setReservationClassDate(localDateTime); // 예약일자
		reservationDTO.setReservationIdx(reservationIdx); // 예약번호
		
		int insertCount = userClassService.registReservation(reservationDTO);
	
		return "redirect:/myPage/payment_info";
	}
	
}
