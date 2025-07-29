package com.itwillbs.clish.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.clish.admin.dto.EventDTO;

public interface AdminEventMapper {

	// 이벤트 리스트
	List<EventDTO> selectAllEvent(@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	// 이벤트 게시물 수
	int selectCountEvent();

	// 이벤트 등록
	int insertEvent(EventDTO eventDTO);

}
