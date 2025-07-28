package com.itwillbs.clish.course.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.core.appender.FileManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.clish.admin.dto.InquiryJoinUserDTO;
import com.itwillbs.clish.admin.mapper.AdminClassMapper;
import com.itwillbs.clish.admin.service.AdminClassService;
import com.itwillbs.clish.admin.service.CategoryService;
import com.itwillbs.clish.admin.service.NotificationService;
import com.itwillbs.clish.common.file.FileDTO;
import com.itwillbs.clish.common.file.FileMapper;
import com.itwillbs.clish.common.file.FileUtils;
import com.itwillbs.clish.course.service.CurriculumService;
import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.course.dto.CurriculumDTO;
import com.itwillbs.clish.course.mapper.CompanyClassMapper;
import com.itwillbs.clish.course.mapper.CurriculumMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class CompanyClassService {
	private final CompanyClassMapper companyClassMapper;
	private final CurriculumService curriculumService;
	private final NotificationService notificationService;
	private final CurriculumMapper curriculumMapper;
	private final FileMapper fileMapper;
	
	@Autowired
	private HttpSession session;
	
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
	
	// 로그인된 userId를 기반으로 해당 회원의 고유 userIdx 반환(기업회원 식별용)
	public String getUserIdxByUserId(String userId) {
		return companyClassMapper.selectUserIdxByUserId(userId);
	}
	
	// 전체 강의 조회
	public List<Map<String, Object>> getAllClassList(String userIdx) {
		return companyClassMapper.selectAllClassList(userIdx);
	}

	// 단기 & 정기 강의 조회
	public List<Map<String, Object>> getClassListByType(String userIdx, String type) {
		return companyClassMapper.selectClassListByType(userIdx, type);
	}
	
	// 클래스 수정
	@Transactional
	public int modifyClassInfo(String classIdx, ClassDTO classInfo, List<CurriculumDTO> curriculumList) {
		 // 1. 클래스 정보 수정
	    int result = companyClassMapper.updateClassInfo(classIdx, classInfo);
	    
	    // 2. 기존 커리큘럼 전부 삭제
	    curriculumMapper.deleteCurriculumByClassIdx(classIdx);
	    
	    // 3. 현재 form에서 온 커리큘럼들을 다시 insert
	    for (CurriculumDTO dto : curriculumList) {
	        if (dto.getCurriculumTitle() != null && !dto.getCurriculumTitle().trim().isEmpty()) {
	            dto.setClassIdx(classIdx); // 커리큘럼이 어떤 클래스 소속인지 꼭 지정
	            curriculumMapper.insertCurriculumModify(dto);
	        }
	    }
	    
		return result;
	}
		
	// 클래스 삭제
	public void deleteClass(String classIdx) {
		companyClassMapper.deleteClass(classIdx);
		
	}

	// 파일 삭제
	public void removeFile(FileDTO fileDTO) {
		fileDTO = fileMapper.selectFile(fileDTO);
		FileUtils.deleteFile(fileDTO, session);
		
		fileMapper.deleteFile(fileDTO);
		
	}
	
	// 클래스 문의 페이지 - 문의 리스트
	public List<InquiryJoinUserDTO> getClassInquiryList(String userIdx) {
		return companyClassMapper.selectClassInquiryList(userIdx);
	}
	
	// 클래스 문의 페이지 - 문의 상세
	public InquiryJoinUserDTO getClassInquiryDetail(String idx) {
		return companyClassMapper.selectClassInquiryDetail(idx);
	}

	// 클래스 문의 페이지 - 문의 답변
	@Transactional
	public int updateClassInquiry(String idx, String userIdx, String inqueryAnswer) {
		int result = companyClassMapper.updateClassInquiry(idx, userIdx, inqueryAnswer);
		
		// 알림 서비스 없이 바로 return
		return result;
	}


	
	
	
	
	
	
}	
	
	 	
	
	