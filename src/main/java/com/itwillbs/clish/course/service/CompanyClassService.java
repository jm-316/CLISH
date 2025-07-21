package com.itwillbs.clish.course.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.clish.admin.mapper.AdminClassMapper;
import com.itwillbs.clish.admin.service.AdminClassService;
import com.itwillbs.clish.admin.service.CategoryService;
import com.itwillbs.clish.admin.service.NotificationService;
import com.itwillbs.clish.course.service.CurriculumService;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.course.dto.CurriculumDTO;
import com.itwillbs.clish.course.mapper.CompanyClassMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class CompanyClassService {
	private final CompanyClassMapper companyClassMapper;
	private final CurriculumService curriculumService;
	private final NotificationService notificationService;
	
	// 강의 등록
	public int registerClass(ClassDTO companyClass) {
		companyClass.setClassStatus(1);
		return companyClassMapper.insertCompanyClass(companyClass);
	}
	
	// 등록한 강의 상세 조회
	public ClassDTO getClassInfo(String classIdx) {
	    ClassDTO classdto = companyClassMapper.selectClassByIdx(classIdx);

	    // classDays 값을 요일 문자열로 변환해서 classDayNames에 넣기
	    if (classdto != null && classdto.getClassDays() != null) {
	    	classdto.setClassDayNames(convertDaysToString(classdto.getClassDays()));
	    }

	    return classdto;
	}

	// 숫자(비트 조합) → "월,수,금" 형태 문자열로 변환하는 함수
	private List<String> convertDaysToString(int days) {
	    String[] dayNames = {"월", "화", "수", "목", "금", "토", "일"};
	    int[] values = {1, 2, 4, 8, 16, 32, 64};

	    List<String> result = new ArrayList<>();
	    for (int i = 0; i < values.length; i++) {
	        if ((days & values[i]) != 0) {
	            result.add(dayNames[i]);
	        }
	    }
	    return result;
	}
	
	// 전체 강의 조회
	public List<Map<String, Object>> getAllClassList() {
		return companyClassMapper.selectAllClassList();
	}

	// 단기 & 정기 강의 조회
	public List<Map<String, Object>> getClassListByType(String type) {
		return companyClassMapper.selectClassListByType(type);
	}
	
	// 클래스 수정
//	@Transactional
//	public int modifyClassInfo(String idx, ClassDTO classInfo, List<CurriculumDTO> curriculumList) {
//		int update = companyClassMapper.updateClassInfo(idx, classInfo);
//		int updateCurriculume = 0;
//		
//		for (CurriculumDTO dto : curriculumList) {
//			updateCurriculume = curriculumService.updateCurriculumeInfo(idx, dto);
//		}
//		
//		if (update > 0 || updateCurriculume > 0) {
//			notificationService.send(classInfo.getUserIdx(), 3, "강좌 정보가 수정되었습니다.");
//			return update;
//		}
//		return 0;
//	}
	
	
	
}	
	
	
	
	