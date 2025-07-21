package com.itwillbs.clish.course.controller;

import java.sql.Date;
//import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.clish.admin.service.AdminClassService;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.course.dto.CurriculumDTO;
import com.itwillbs.clish.course.service.CompanyClassService;
import com.itwillbs.clish.course.service.CurriculumService;
import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/company")
@RequiredArgsConstructor
public class CompanyClassController {
	private final CompanyClassService companyClassService;
	private final AdminClassService adminClassService;
	private final CurriculumService curriculumService;
	
	// 기업 메인페이지
	@GetMapping("")
	public String companyMainForm() {
		return "company/company_main";	
	}

	
	// 기업 마이페이지
	@GetMapping("/myPage")
	public String comMyPage() {
		return "company/myPage"; 
	}
	
	// 클래스 관리 페이지
	@GetMapping("/myPage/classManage")
    public String classManageForm(@RequestParam(required = false) String type, Model model) {
		// 클래스 개설되는지 확인용(임시) - adminClassService => companyClassService 로 잠시 변경
		List<Map<String , Object>> classList = companyClassService.getAllClassList();
		// 관리자 승인 후 목록 확인이 되게 adminClassSerive 로 적음
//		List<Map<String , Object>> classList = adminClassService.getClassList();
		
		if (type == null || type.isBlank()) {
			// 전체
		    classList = companyClassService.getAllClassList();
		} else if (type.equals("short") || type.equals("regular")) {
			// 단기 & 정기
		    classList = companyClassService.getClassListByType(type);
		} else {
		    // 혹시나 잘못된 type 들어온 경우 대비
		    classList = companyClassService.getAllClassList();
		}
		
		model.addAttribute("classList", classList);
		
        return "/company/companyClass/classManage"; 
    }
	
	
	// 클래스 개설 페이지
	@GetMapping("/myPage/registerClass")
    public String registerClassForm() {
        return "/company/companyClass/registerClass"; 
    }
	
	// 클래스 개설 로직
	@PostMapping("/myPage/registerClass")
	public String registerClassSubmit(ClassDTO companyClass, Model model, HttpServletRequest request) {
		// 고유 번호 생성 - 등록 시점에서 class_idx를 직접 만들어 넣기 (예: CLS202507132152)
		String classIdx = "CLS" + new SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
		companyClass.setClassIdx(classIdx);
		
		// -------------------------------------------------------------------
		// 수강료 기본값 처리
		if(companyClass.getClassPrice() == null) {
			companyClass.setClassPrice(BigDecimal.ZERO);
		}
	    // ------------------------------------------------------------------------------------------------------
		// 체크박스(요일) 처리: List<String> → int
		int classDaysValue = 0;
		List<String> tempDays = companyClass.getClassDayNames();

		if (tempDays != null) {
		    for (int i = 0; i < tempDays.size(); i++) {
		        String val = tempDays.get(i);
		        classDaysValue += Integer.parseInt(val);
		    }
		}
		companyClass.setClassDays(classDaysValue);
		companyClass.setUserIdx("comp2025010120250711");
		companyClass.setCategoryIdx("CT_it_backend");
	    // ------------------------------------------------------------------------------------------------------
	    // 강좌 등록
	    int result = companyClassService.registerClass(companyClass);
	    // ------------------------------------------------------------------------------------------------------
	    // 커리큘럼 등록 로직 (폼에서 여러 개 받아온 값 처리)
	    String[] titles = request.getParameterValues("curriculumTitle");
	    String[] runtimes = request.getParameterValues("curriculumRuntime");

	    if (titles != null && runtimes != null) {
	        for (int i = 0; i < titles.length; i++) {
	            CurriculumDTO curri = new CurriculumDTO();
	            curri.setCurriculumIdx("CURI" + UUID.randomUUID().toString().substring(0, 8));
	            curri.setClassIdx(classIdx); // 외래키 설정
	            curri.setCurriculumTitle(titles[i]);
	            curri.setCurriculumRuntime(runtimes[i]);

	            curriculumService.insertCurriculum(curri);
	        }
	    }
	    
	    if (result > 0) {
	    	model.addAttribute("msg", "강좌 개설이 완료되었습니다.");
	    	model.addAttribute("targetURL", "/company/myPage/classDetail?classIdx=" + companyClass.getClassIdx());
	    } else {
	    	model.addAttribute("msg", "강좌 개설에 실패했습니다. 다시 시도해주세요.");
//	    	model.addAttribute("targetURL", "/company/myPage/classManage");
	    }
	    
	    return "commons/result_process";
	}

	
	// 클래스 상세 페이지
	@GetMapping("/myPage/classDetail")
	public String classDetailForm(@RequestParam String classIdx, Model model) {
		
		ClassDTO classInfo = companyClassService.getClassInfo(classIdx);
		model.addAttribute("classInfo", classInfo);
		
		// 커리큘럼 목록 조회
	    List<CurriculumDTO> curriculumList = curriculumService.getCurriculumList(classIdx);
	    model.addAttribute("curriculumList", curriculumList);
		
		return "company/companyClass/classDetail";
	}
	
	// 클래스 수정 페이지
	@GetMapping("/myPage/modifyClass")
	public String modifyClassForm(@RequestParam String classIdx, Model model) {
		ClassDTO classInfo = companyClassService.getClassInfo(classIdx);
		List<CurriculumDTO> curriculumList = curriculumService.getCurriculumList(classIdx);
		
		model.addAttribute("classInfo", classInfo);
	    model.addAttribute("curriculumList", curriculumList);
		
		return "/company/companyClass/modifyClass";
	}
	
	// 클래스 수정 로직
}
