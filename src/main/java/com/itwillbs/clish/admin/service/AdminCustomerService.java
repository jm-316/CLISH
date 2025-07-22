package com.itwillbs.clish.admin.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.clish.admin.dto.SupportDTO;
import com.itwillbs.clish.admin.mapper.AdminCustomerMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminCustomerService {
	private final AdminCustomerMapper adminCustomerMapper;

	// 공지사항 리스트 
	public List<SupportDTO> getNoticeList() {
		return adminCustomerMapper.selectNotices();
	}

	public void registNotice(SupportDTO supportDTO) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		String timestamp = LocalDateTime.now().format(formatter);
		supportDTO.setSupportIdx("SUP" + timestamp);
		supportDTO.setSupportCategory("공지사항");
		
		adminCustomerMapper.insertNotice(supportDTO);
	}

	public SupportDTO getNotice(String idx) {
		return adminCustomerMapper.selectNotice(idx);
	}

	public int modifyNotice(SupportDTO supportDTO) {
		return adminCustomerMapper.updateNotice(supportDTO);
	}

	public int removeNotice(String idx) {
		return adminCustomerMapper.deleteNotice(idx);
	}

}
