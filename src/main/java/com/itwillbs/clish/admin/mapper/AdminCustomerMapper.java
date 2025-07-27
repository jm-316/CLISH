package com.itwillbs.clish.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.clish.admin.dto.InquiryJoinUserDTO;
import com.itwillbs.clish.admin.dto.SupportDTO;
import com.itwillbs.clish.myPage.dto.InqueryDTO;

public interface AdminCustomerMapper {

//	List<SupportDTO> selectNotices();

	void insertSupport(SupportDTO supportDTO);

	SupportDTO selectSupport(String idx);

	int updateSupport(SupportDTO supportDTO);

	int deleteSupport(String idx);

	List<SupportDTO> selectFaqList();

	SupportDTO selectFaq(String idx);

	// 1:1 문의 리스트(페이지네이션)
	List<InquiryJoinUserDTO> selectInquiries(@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	InquiryJoinUserDTO selectInquiry(String idx);

	// 관리자 문의 답변
	int updateInquiry(@Param("idx") String idx, @Param("inqueryAnswer") String inqueryAnswer);

	int selectCountAnnouncement();

	List<SupportDTO> selectAnnouncements(@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	int insertInquery(InqueryDTO inqueryDTO);

	int selectInquiryCount();

	int deleteInquiry(String idx);

	// 1:1 문의 수정
	int updateUserInquiry(InqueryDTO inqueryDTO);

}
