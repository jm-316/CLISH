package com.itwillbs.clish.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.clish.admin.mapper.AdminUserMapper;
import com.itwillbs.clish.common.file.FileDTO;
import com.itwillbs.clish.common.file.FileUtils;
import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class AdminUserService {
	private final AdminUserMapper adminMapper;
	private final NotificationService notificationService;
	
	// 일반 정보 리스트
	public List<UserDTO> getUserList() {
		return adminMapper.selectUserList();
	}
	
	// 일반 유저 상세 정보
	public UserDTO getuserInfo(String idx) {
		return adminMapper.selectUserInfo(idx);
	}
	
	// 기업 정보 리스트
	public List<UserDTO> getCompanyList() {
		return adminMapper.selectCompanyList();
	}

	// 기업 상세 정보
	public UserDTO getcompanyInfo(String idx) {
		return adminMapper.selectCompanyInfo(idx);
	}

	// 상태 변경
	public int setUserStatus(String idx, int status) {
		return adminMapper.updateUserStatus(idx, status);
	}

	// 승인 또는 탈퇴 로직
	@Transactional
	public int modifyStatus(String idx, int status) {
		int update = adminMapper.updateUserStatus(idx, status);
		
		if (update > 0) {
			if (status == 1) {
				notificationService.send(idx, 5, "가입이 승인되었습니다.");			
			} 
			return update;
		}
		
		return 0;
	}

	public CompanyDTO getCompanyBizReg(String idx) {
		return adminMapper.selectCompanyBizReg(idx);
	}

}
