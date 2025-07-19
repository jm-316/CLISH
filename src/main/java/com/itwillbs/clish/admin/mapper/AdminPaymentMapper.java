package com.itwillbs.clish.admin.mapper;

import java.util.List;

import com.itwillbs.clish.myPage.dto.PaymentInfoDTO;

public interface AdminPaymentMapper {

	// 결제 정보 리스트
	List<PaymentInfoDTO> selectPaymentList();

}
