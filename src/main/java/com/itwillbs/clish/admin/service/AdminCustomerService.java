package com.itwillbs.clish.admin.service;

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

}
