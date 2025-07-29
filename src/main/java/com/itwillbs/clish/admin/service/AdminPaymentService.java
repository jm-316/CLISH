package com.itwillbs.clish.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.clish.admin.mapper.AdminPaymentMapper;
import com.itwillbs.clish.myPage.dto.PaymentInfoDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class AdminPaymentService {
	private final AdminPaymentMapper adminPaymentMapper;
	
	// 결제 리스트
	public List<PaymentInfoDTO> getPaymentList() {
		return adminPaymentMapper.selectPaymentList();
	}

}
