package com.itwillbs.clish.course.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.clish.admin.service.NotificationService;
import com.itwillbs.clish.course.dto.CurriculumDTO;
import com.itwillbs.clish.course.mapper.CompanyClassMapper;
import com.itwillbs.clish.course.mapper.CurriculumMapper;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class CurriculumService {
	private final CurriculumMapper curriculumMapper;

    
    // 커리큘럼 등록
	public void insertCurriculum(CurriculumDTO curri) {
		curriculumMapper.insertCurriculum(curri);
		
	}
	
	// 상세페이지에서 커리큘럼 목록 조회
	public List<CurriculumDTO> getCurriculumList(String classIdx) {
		return curriculumMapper.selectCurriculumList(classIdx);
	}

	public int updateCurriculumeInfo( String idx, CurriculumDTO dto) {
		return curriculumMapper.updateCurriculum(idx, dto);
	}
	
	 	
}
