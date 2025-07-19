package com.itwillbs.clish.admin.controller;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.clish.admin.service.AdminPaymentService;
import com.itwillbs.clish.myPage.dto.PaymentCancelDTO;
import com.itwillbs.clish.myPage.dto.PaymentInfoDTO;
import com.itwillbs.clish.myPage.service.PaymentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("admin")
@RequiredArgsConstructor
public class AdminPaymentController {
	private final AdminPaymentService adminPaymentService;
	private final PaymentService paymentService;
	
	@GetMapping("/paymentList")
	public String paymentList(Model model) {
		List<PaymentInfoDTO> paymentList = adminPaymentService.getPaymentList();
		
		model.addAttribute("paymentList", paymentList);
		
		return "/admin/payment/payment_list";
	}
	
	@GetMapping("/payment_info/paymentDetail")
	public String paymentInfo(PaymentInfoDTO paymentInfoDTO, Model model) {
		paymentInfoDTO = paymentService.getPayResult(paymentInfoDTO);
		String payTime = paymentService.convertUnixToDateTimeString(paymentInfoDTO.getPayTime()/1000L);
		String requestTime = paymentService.convertUnixToDateTimeString(paymentInfoDTO.getRequestTime()/1000L);
		
		model.addAttribute("paymentInfoDTO",paymentInfoDTO);
		model.addAttribute("requestTime",requestTime);
		model.addAttribute("payTime",payTime);
		return "/clish/myPage/myPage_payment_payResult";
	}
	
	@GetMapping("/payment_info/cancelDetail")
	public String cancelPaymentForm(PaymentCancelDTO paymentCancelDTO, Model model) {
		paymentCancelDTO = paymentService.getCancelResult(paymentCancelDTO);
    	String requestTime = paymentService.convertUnixToDateTimeString(paymentCancelDTO.getCancelRequestTime()/1000L);
    	
    	model.addAttribute("requestTime",requestTime);
    	model.addAttribute("paymentCancel", paymentCancelDTO);
    	model.addAttribute("message", "결제 취소가 정상 처리되었습니다.");
		
		return "/clish/myPage/myPage_payment_cancelResult";
	}

}
