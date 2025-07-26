package com.itwillbs.clish.admin.service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.clish.admin.dto.InquiryJoinUserDTO;
import com.itwillbs.clish.admin.dto.SupportDTO;
import com.itwillbs.clish.admin.mapper.AdminCustomerMapper;
import com.itwillbs.clish.common.file.FileDTO;
import com.itwillbs.clish.common.file.FileMapper;
import com.itwillbs.clish.common.file.FileUtils;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminCustomerService {
	private final AdminCustomerMapper adminCustomerMapper;
	private final NotificationService notificationService;
	private final FileMapper fileMapper;
	
	@Autowired
	private HttpSession session;

	// 공지사항 게시물 수 
	public int getAnnouncementCount() {
		return adminCustomerMapper.selectCountAnnouncement();
	}
	
	// 공지사항 리스트 (페이지 기능 추가)
	public List<SupportDTO> getAnnouncementList(int startRow, int listLimit) {
		return adminCustomerMapper.selectAnnouncements(startRow, listLimit);
	}
	
	// SUPPORT 테이블 등록
	@Transactional
	public void registSupport(SupportDTO supportDTO) throws IllegalStateException, IOException {
		supportDTO.setSupportIdx(createIdx());
		
		if (supportDTO.getSupportCategory() == null) {
			supportDTO.setSupportCategory("공지사항");
		}
		
		if (supportDTO.getFiles() != null && supportDTO.getFiles().length > 0) {
			List<FileDTO> supportFileList = FileUtils.uploadFile(supportDTO, session);
			
			if (!supportFileList.isEmpty()) {
				fileMapper.insertFiles(supportFileList);
			}
		}
		
		adminCustomerMapper.insertSupport(supportDTO);
	}
	
	// SUPPORT 테이블 상세 정보
	public SupportDTO getSupport(String idx) {
		return adminCustomerMapper.selectSupport(idx);
	}

	// SUPPORT 테이블 수정
	public int modifySupport(SupportDTO supportDTO) throws IllegalStateException, IOException {
		supportDTO.setSupportCategory("공지사항");
		List<FileDTO> fileList = FileUtils.uploadFile(supportDTO, session);
		
		if(!fileList.isEmpty()) {
			fileMapper.insertFiles(fileList);
		}
		return adminCustomerMapper.updateSupport(supportDTO);
	}

	// SUPPORT 테이블 삭제
	@Transactional
	public int removeSupport(String idx) {
		List<FileDTO> fileDTOList = fileMapper.selectAllFile(idx);
		FileUtils.deleteFiles(fileDTOList, session);
		
		fileMapper.deleteAllFile(idx);
		
		return adminCustomerMapper.deleteSupport(idx);
	}

	// faq 리스트
	public List<SupportDTO> getFaqList() {
		return adminCustomerMapper.selectFaqList();
	}
	
	// faq 수정
	public int modifyFaq(SupportDTO supportDTO) {
		return adminCustomerMapper.updateSupport(supportDTO);
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

	// 파일 삭제
	public void removeFile(FileDTO fileDTO) {
		fileDTO = fileMapper.selectFile(fileDTO);
		FileUtils.deleteFile(fileDTO, session);
		
		fileMapper.deleteFile(fileDTO);
	}
	
	// 아이디 생성 로직
	private String createIdx() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		String timestamp = LocalDateTime.now().format(formatter);
		String idx = "SUP" + timestamp;
		
		return idx;
	}




}
