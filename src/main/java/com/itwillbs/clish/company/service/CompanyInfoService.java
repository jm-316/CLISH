package com.itwillbs.clish.company.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.clish.admin.dto.InquiryJoinUserDTO;
import com.itwillbs.clish.company.mapper.CompanyInfoMapper;
import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CompanyInfoService {
	private final CompanyInfoMapper companyInfoMapper;
	
	// 로그인한 기업회원 정보 조회
	public UserDTO getUserInfo(UserDTO user) {
		return companyInfoMapper.selectUserInfo(user);
	}
	
	// 기업회원 정보 수정 처리 
	public int setUserInfo(UserDTO user) {
		return companyInfoMapper.updateUserInfo(user);
		
	}
	
	// 기업회원 사업자등록증 정보 수정 처리
	public int setCompanyInfo(CompanyDTO company) {
		return companyInfoMapper.updateCompanyInfo(company);
		
	}
	
	// 기업 - 나의 문의 목록(리스트) 조회
	public List<InquiryJoinUserDTO> getInquiriesByUserIdx(String userIdx) {
		return companyInfoMapper.selectInquiriesByUserIdx(userIdx);
	}
	
	// 문의 등록버튼 로직
	public void insertInquery(InqueryDTO dto) {
		companyInfoMapper.insertInquery(dto); 
	}
	
	// user_id로 실제 user_idx 조회
	public String getUserIdxByUserId(String userId) {
		return companyInfoMapper.selectUserIdxByUserId(userId);
	}

	

	
}
