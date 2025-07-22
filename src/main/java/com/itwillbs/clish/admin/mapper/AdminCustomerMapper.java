package com.itwillbs.clish.admin.mapper;

import java.util.List;

import com.itwillbs.clish.admin.dto.SupportDTO;

public interface AdminCustomerMapper {

	List<SupportDTO> selectNotices();

	void insertSupport(SupportDTO supportDTO);

	SupportDTO selectSupport(String idx);

	int updateSupport(SupportDTO supportDTO);

	int deleteSupport(String idx);

	List<SupportDTO> selectFaqList();

	SupportDTO selectFaq(String idx);

}
