package com.itwillbs.clish.admin.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.clish.admin.dto.InquiryJoinUserDTO;
import com.itwillbs.clish.admin.dto.SupportDTO;
import com.itwillbs.clish.admin.mapper.AdminCustomerMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminCustomerService {
	private final AdminCustomerMapper adminCustomerMapper;
	private final NotificationService notificationService;

	// 공지사항 리스트 
	public List<SupportDTO> getNoticeList() {
		return adminCustomerMapper.selectNotices();
	}

	// SUPPORT 테이블 등록
	public void registSupport(SupportDTO supportDTO) {
		supportDTO.setSupportIdx(createIdx());
		
		if (supportDTO.getSupportCategory() == null) {
			supportDTO.setSupportCategory("공지사항");
		}
		
		adminCustomerMapper.insertSupport(supportDTO);
	}
	
	// SUPPORT 테이블 상세 정보
	public SupportDTO getSupport(String idx) {
		return adminCustomerMapper.selectSupport(idx);
	}

	// SUPPORT 테이블 수정
	public int modifySupport(SupportDTO supportDTO) {
		return adminCustomerMapper.updateSupport(supportDTO);
	}

	// SUPPORT 테이블 삭제
	public int removeSupport(String idx) {
		return adminCustomerMapper.deleteSupport(idx);
	}

	// faq 리스트
	public List<SupportDTO> getFaqList() {
		return adminCustomerMapper.selectFaqList();
	}

	public List<InquiryJoinUserDTO> getInquiryList() {
		return adminCustomerMapper.selectInquiryList();
	}

	public InquiryJoinUserDTO getInquiry(String idx) {
		return adminCustomerMapper.selectInquiry(idx);
	}
	
	@Transactional
	public int writeAnswer(String idx, String userIdx, String inqueryAnswer) {
		int update = adminCustomerMapper.updateInquiry(idx, inqueryAnswer);
		
		if (update > 0) {
			notificationService.send(userIdx, 2, "문의하신 내용에 답변이 달렸습니다.");
			return update;
		}
		
		return 0;
	}
	
	// 아이디 생성 로직
	private String createIdx() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		String timestamp = LocalDateTime.now().format(formatter);
		String idx = "SUP" + timestamp;
		
		return idx;
	}


}
