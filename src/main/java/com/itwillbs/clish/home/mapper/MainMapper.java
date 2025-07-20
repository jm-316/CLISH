package com.itwillbs.clish.home.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.clish.course.dto.ClassDTO;

@Mapper
public interface MainMapper {
	

	List<ClassDTO> selectClassInfo();
}
