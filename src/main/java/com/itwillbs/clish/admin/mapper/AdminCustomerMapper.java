package com.itwillbs.clish.admin.mapper;

import java.util.List;

import com.itwillbs.clish.admin.dto.SupportDTO;

public interface AdminCustomerMapper {

	List<SupportDTO> selectNotices();

	void insertNotice(SupportDTO supportDTO);

	SupportDTO selectNotice(String idx);

	int updateNotice(SupportDTO supportDTO);

	int deleteNotice(String idx);

}
