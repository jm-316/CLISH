package com.itwillbs.clish.course.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.clish.course.dto.CurriculumDTO;

@Mapper
public interface CurriculumMapper {
	
	// 커리큘럼 등록
	void insertCurriculum(CurriculumDTO curri);
	
	// 상세페이지에서 커리큘럼 목록 조회
	List<CurriculumDTO> selectCurriculumList(String classIdx);

	int updateCurriculum(@Param("idx") String idx, @Param("curriculumInfo") CurriculumDTO curriculumInfo);
	

}
