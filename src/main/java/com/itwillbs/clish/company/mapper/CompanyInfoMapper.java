package com.itwillbs.clish.company.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;


@Mapper
public interface CompanyInfoMapper {
	
	// 로그인한 기업회원 정보 조회
	UserDTO selectUserInfo(UserDTO user);
	
	// 기업 정보 수정
	int updateUserInfo(UserDTO user);
	
	// 기업회원 사업자등록증 정보 수정 처리
	int updateCompanyInfo(CompanyDTO company);

	// 기업 - 문의 작성/수정 폼 열기
	InqueryDTO selectInqueryByIdx(String inqueryIdx);
	
	// 나의 문의 신규 등록
//	void insertInquiry(InqueryDTO inqueryDTO);
	
	// 나의 문의 수정
//	void updateInquiry(InqueryDTO inqueryDTO);
	

}
