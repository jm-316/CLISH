package com.itwillbs.clish.company.service;

import org.springframework.stereotype.Service;

import com.itwillbs.clish.company.mapper.CompanyInfoMapper;
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
	
	
}
