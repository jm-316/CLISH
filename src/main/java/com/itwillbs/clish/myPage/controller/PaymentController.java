package com.itwillbs.clish.myPage.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.clish.myPage.dto.PaymentCancelDTO;
import com.itwillbs.clish.myPage.dto.PaymentInfoDTO;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.myPage.service.MyPageService;
import com.itwillbs.clish.myPage.service.PaymentService;
import com.itwillbs.clish.user.dto.UserDTO;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/myPage")
public class PaymentController {
	private final PaymentService paymentService;
	private final MyPageService myPageService;
	
	//결제페이지
	@GetMapping("/payment_info/payReservation")
	public String payReservationForm(HttpSession session, Model model,
			ReservationDTO reservation, UserDTO user) {		
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		user = myPageService.getUserInfo(user); // 예약자 정보
		Map<String,Object> reservationClassInfo = myPageService.reservationDetailInfo(reservation);
		
		model.addAttribute("reservationClassInfo", reservationClassInfo);
		model.addAttribute("user",user);
		return "/clish/myPage/myPage_payment_payForm";
	}
	
	// 결제요청 버튼 결제 진행 후 리스폰 리턴맵핑  	
	@PostMapping(value="/payment/verify", produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> verifyPayment(@RequestParam String imp_uid) {
		long requestTime = System.currentTimeMillis();

		Map<String, Object> result = new HashMap<> ();
		try {
			IamportClient iamportClient = paymentService.getkey();
			IamportResponse<Payment> response = iamportClient.paymentByImpUid(imp_uid);
			Payment payment = response.getResponse();
			result.put("impUid", payment.getImpUid()); // 포트원 결제 고유번호
			result.put("merchantUid", payment.getMerchantUid()); // 주문번호(예약번호)
			result.put("amount", payment.getAmount()); // 결제금액
			result.put("status", payment.getStatus()); // 구매상태(paid , ready, cancelled)
			result.put("userName", payment.getBuyerName()); //구매자 이름
			result.put("payMethod", payment.getPayMethod()); // 결제수단
			result.put("payTime", payment.getPaidAt()); // 결제시각
			result.put("classTitle", payment.getName()); // 상품명(강의명)
			result.put("requestTime", requestTime);
			result.put("receiptUrl", payment.getReceiptUrl());
			System.out.println("영수증요청 " + payment.getReceiptUrl());
		} catch (IamportResponseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	    return result;
	}
	
	// 결제결과데이터 저장
	@GetMapping("/payment_info/payResult")
	public String payResultPage( PaymentInfoDTO paymentInfoDTO, Model model, RedirectAttributes redirectAttributes) {
		paymentService.putPayInfo(paymentInfoDTO);
		redirectAttributes.addAttribute("impUid",paymentInfoDTO.getImpUid());
	    return "redirect:/myPage/payment_info/paymentDetail"; // JSP 파일명에 맞게 수정
	}
		
	//결제상세보기페이지
	@GetMapping("/payment_info/paymentDetail")
	public String paymentInfo(PaymentInfoDTO paymentInfoDTO, UserDTO user,Model model) {
		paymentInfoDTO = paymentService.getPayResult(paymentInfoDTO);
		String payTime = paymentService.convertUnixToDateTimeString(paymentInfoDTO.getPayTime()/1000L);
		String requestTime = paymentService.convertUnixToDateTimeString(paymentInfoDTO.getRequestTime()/1000L);
		
		model.addAttribute("paymentInfoDTO",paymentInfoDTO);
		model.addAttribute("requestTime",requestTime);
		model.addAttribute("payTime",payTime);
		return "/clish/myPage/myPage_payment_payResult";
	}
	
	//결제취소: 결제취소창으로이동
	@GetMapping("/payment_info/cancelPayment")
	public String cancelPaymentForm(PaymentInfoDTO paymentInfoDTO, Model model) {
		paymentInfoDTO = paymentService.getPayResult(paymentInfoDTO);
		String requestTime = paymentService.convertUnixToDateTimeString(paymentInfoDTO.getRequestTime()/1000L);
		String payTime = paymentService.convertUnixToDateTimeString(paymentInfoDTO.getPayTime()/1000L);
		
		model.addAttribute("paymentInfoDTO",paymentInfoDTO);
		model.addAttribute("payTime",payTime);
		
		return "/clish/myPage/myPage_payment_cancelForm";
	}
	
	// 결제 취소 요청맵핑
	@PostMapping("/payment_info/cancelPayment")
	public String cancelPayment(PaymentCancelDTO paymentCancelDTO, Model model, RedirectAttributes redirectAttributes) {
		String accessToken = paymentService.getAccessToken();
		String cancelUrl = "https://api.iamport.kr/payments/cancel";
		
		long cancelRequestTime = System.currentTimeMillis();

		Map<String, Object> cancelRequest = new HashMap<>();
		cancelRequest.put("imp_uid", paymentCancelDTO.getImpUid());
		cancelRequest.put("reason", paymentCancelDTO.getCancelReason());

		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", accessToken);
		headers.setContentType(MediaType.APPLICATION_JSON);

		HttpEntity<Map<String, Object>> request = new HttpEntity<>(cancelRequest, headers);
		
//--------------------------------------------------------------------------------------------------
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Map> cancelResponse = restTemplate.postForEntity(cancelUrl, request, Map.class);
		
		Map<String, Object> responseBody = cancelResponse.getBody();
	    int code = (int) responseBody.get("code");
	    
	    Map<String, Object> responseMap = (Map<String, Object>) responseBody.get("response");
	    
	   	    
	    if (responseMap != null) {
	        ObjectMapper mapper = new ObjectMapper();
	        paymentCancelDTO = mapper.convertValue(responseMap, PaymentCancelDTO.class);
	    	paymentCancelDTO.setCancelRequestTime(cancelRequestTime);
	    	String cancelReceiptUrl = String.join(",", paymentCancelDTO.getCancelReceiptUrls());
	    	paymentCancelDTO.setCancelReceiptUrl(cancelReceiptUrl);
	    }
	    
	    if (code == 0) {
	    	paymentService.cancelComplete(paymentCancelDTO);
	    	redirectAttributes.addAttribute("impUid",paymentCancelDTO.getImpUid());
			return "redirect:/myPage/payment_info/cancelDetail";
	    } else {
	        String errorMsg = (String) responseBody.get("message");
	        model.addAttribute("message", "결제 취소 실패: " + errorMsg);
	    	model.addAttribute("paymentCancel", paymentCancelDTO);
	    	return "/clish/myPage/myPage_payment_cancelResult";
	    }
	}
	
	//취소상세 페이지
	@GetMapping("payment_info/cancelDetail")
	public String cancelInfo(Model model, PaymentCancelDTO paymentCancelDTO, UserDTO user) {
		paymentCancelDTO = paymentService.getCancelResult(paymentCancelDTO);
    	String requestTime = paymentService.convertUnixToDateTimeString(paymentCancelDTO.getCancelRequestTime()/1000L);
    	String cancelTime = paymentService.convertUnixToDateTimeString(paymentCancelDTO.getCancelledAt()/1000L);

    	model.addAttribute("requestTime",requestTime);
    	model.addAttribute("cancelTime",cancelTime);
    	model.addAttribute("paymentCancel", paymentCancelDTO);
    	model.addAttribute("message", "결제 취소가 정상 처리되었습니다.");
		
		return "/clish/myPage/myPage_payment_cancelResult";
	}
}
