package com.itwillbs.clish.admin.service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.clish.admin.dto.EventDTO;
import com.itwillbs.clish.admin.mapper.AdminEventMapper;
import com.itwillbs.clish.common.file.FileDTO;
import com.itwillbs.clish.common.file.FileMapper;
import com.itwillbs.clish.common.file.FileUtils;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminEventService {
	private final AdminEventMapper adminEventMapper;
	private final FileMapper fileMapper;
	
	@Autowired
	private HttpSession session;

	// 이벤트 리스트
	public List<EventDTO> getEvents(int startRow, int listLimit) {
		return adminEventMapper.selectAllEvent(startRow, listLimit);
	}

	// 이벤트 게시물 수
	public int getEventCount() {
		return adminEventMapper.selectCountEvent();
	}

	// 이벤트 등록
	@Transactional
	public int registEvent(EventDTO eventDTO) throws IllegalStateException, IOException {
		eventDTO.setEventIdx(createIdx("EVT"));
		int insert = adminEventMapper.insertEvent(eventDTO);
		
		// 이벤트 등록 성공 시 파일 등록 실행
		if (insert > 0) {
			if (eventDTO.getFiles() != null && eventDTO.getFiles().length > 0) {
				List<FileDTO> eventFileList = FileUtils.uploadFile(eventDTO, session);
				
				for (int i = 0; i < eventFileList.size(); i++) {
					FileDTO file = eventFileList.get(i);
					
					// index 0은 썸네일, index 1은 컨텐츠라고 간주
					if (i == 0) {
						fileMapper.insertThumbnail(file);
					} else if (i == 1) {
						fileMapper.insertOneFile(file);
					}
				}
			}
		} else {
			 throw new RuntimeException("이벤트 등록에 실패했습니다.");
		}
		
		return insert;
	}

	// 아이디 생성 로직
	private String createIdx(String name) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		String timestamp = LocalDateTime.now().format(formatter);
		String idx = name + timestamp;
		
		return idx;
	}

}
