package com.itwillbs.clish.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.clish.admin.dto.InquiryJoinUserDTO;
import com.itwillbs.clish.admin.dto.SupportDTO;

public interface AdminCustomerMapper {

	List<SupportDTO> selectNotices();

	void insertSupport(SupportDTO supportDTO);

	SupportDTO selectSupport(String idx);

	int updateSupport(SupportDTO supportDTO);

	int deleteSupport(String idx);

	List<SupportDTO> selectFaqList();

	SupportDTO selectFaq(String idx);

	List<InquiryJoinUserDTO> selectInquiryList();

	InquiryJoinUserDTO selectInquiry(String idx);

	int updateInquiry(@Param("idx") String idx, @Param("inqueryAnswer") String inqueryAnswer);

}
