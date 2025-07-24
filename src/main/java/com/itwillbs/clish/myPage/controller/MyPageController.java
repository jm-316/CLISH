package com.itwillbs.clish.myPage.controller;

import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.clish.common.dto.FileDTO;
import com.itwillbs.clish.common.dto.PageInfoDTO;
import com.itwillbs.clish.common.utils.PageUtil;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.myPage.dto.PaymentInfoDTO;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.myPage.service.MyPageService;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;
import retrofit2.http.GET;

@Controller
@RequiredArgsConstructor
@RequestMapping("/myPage")
public class MyPageController {
	private final MyPageService myPageService;
	
	// 마이페이지 메인
	@GetMapping("/main")
	public String myPage_main() {
		return "/clish/myPage/myPage_main";
	}
	
	// 마이페이지 정보변경
	@GetMapping("/change_user_info")
	public String mypage_change_user_info_main(HttpSession session) {
		return "/clish/myPage/myPage_change_user_info";
	}
	
	// 비밀번호 확인 일치시 수정페이지로 불일치시 비밀번호가 틀렸습니다 메시지
	@PostMapping("/change_user_info_form")
	public String mypage_change_user_info_form(UserDTO user, HttpSession session, Model model) {
		String inputPw = user.getUserPassword();
			
		user.setUserId((String)session.getAttribute("sId"));
		user = myPageService.getUserInfo(user);
		
		if(user.getUserPassword().equals(inputPw)) {
			model.addAttribute("user", user);
			return "clish/myPage/myPage_change_user_info_form"; //비밀번호 일치시 이동페이지
		}
		
		model.addAttribute("msg","비밀번호가 틀렸습니다.");
		model.addAttribute("targetUrl","myPage/change_user_info_form");
		return "commons/result_process";
	}
	
	// 수정정보 UPDATE문 으로 반영후 정보변경 메인페이지로 이동
	@PostMapping("/change_user_info")
	public String mypage_change_user_info(UserDTO user, HttpSession session,
			@RequestParam("newPasswordConfirm") String new_password) {
		user.setUserId((String)session.getAttribute("sId"));
		
		UserDTO user1 = myPageService.getUserInfo(user); // 기존 유저 정보 불러오기

		if(!user1.getUserEmail().equals(user.getUserEmail())){
			user.setNewEmail(user.getUserEmail());
		}
		
		if(!new_password.isEmpty()) { // 새비밀번호가 있다면 비밀번호 새로지정
			user.setUserPassword(new_password);
		}else { // 아니면 기존 비밀번호 유지
			user.setUserPassword(user1.getUserPassword());
		}
				
		myPageService.setUserInfo(user);
		
		return "redirect:/myPage/change_user_info";
	}
	
	//------------------------------------------------------------------------------------
	//결제내역
	// 예약/결제 목록 불러오기
	@GetMapping("/payment_info")
	public String payment_info(HttpSession session, Model model,UserDTO user
			, @RequestParam(defaultValue = "1") int reservationPageNum
			, @RequestParam(defaultValue = "1") int paymentPageNum) {
		String sId = (String)session.getAttribute("sId");
		user.setUserId(sId);
		user = myPageService.getUserInfo(user);
		int listLimit = 5;
		int reservationListCount = myPageService.getReservationCount(user);
		int paymentListCount = myPageService.getPaymentCount(user);
		
		if(reservationListCount > 0 ) {
			PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, reservationListCount, reservationPageNum, 3);
			
			if(reservationPageNum < 1 || reservationPageNum > pageInfoDTO.getMaxPage()) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "/myPage/payment_info"); // 기본 페이지가 1페이지이므로 페이지 파라미터 불필요
				return "commons/result_process";
			}
			model.addAttribute("reservationPageInfo", pageInfoDTO);

			List<ReservationDTO> reservationList = myPageService.getReservationInfo(pageInfoDTO.getStartRow(), listLimit, user);
			model.addAttribute("reservationList",reservationList);

		}
		if(paymentListCount > 0) {
			PageInfoDTO pageInfoDTO = PageUtil.paging(5, paymentListCount, paymentPageNum, 3);
			
			if(paymentPageNum < 1 || paymentPageNum > pageInfoDTO.getMaxPage()) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "/myPage/payment_info"); // 기본 페이지가 1페이지이므로 페이지 파라미터 불필요
				return "commons/result_process";
			}
			model.addAttribute("paymentPageInfo", pageInfoDTO);

			List<PaymentInfoDTO> paymentList = myPageService.getPaymentList(pageInfoDTO.getStartRow(), listLimit, user);
			model.addAttribute("paymentList",paymentList);
		}
		model.addAttribute("user",user);
		
		return "/clish/myPage/myPage_payment";

	}
	
	//예약 취소
	@PostMapping(value="/payment_info/cancel", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String cancelReservation(HttpSession session, ReservationDTO reservation) {
		System.out.println("reservationIdx" + reservation.getReservationIdx());
		String reservationIdx = reservation.getReservationIdx();
		reservation.setReservationIdx(reservationIdx);
		System.out.println("DTO : " + reservation.getReservationIdx());
	    int count = myPageService.cancelReservation(reservation);
	    if(count == 0) {
	    	return "예약취소 실패";
	    }
	    return "예약이 취소되었습니다!";
	}
	
	
	//예약상세보기
	@GetMapping("/payment_info/detail")
	public String reservationDetail(HttpSession session, Model model, ReservationDTO reservation, UserDTO user, ClassDTO claSs) {
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		user = myPageService.getUserInfo(user); // 예약자 정보
		
		Map<String,Object> reservationDetailInfo = myPageService.reservationDetailInfo(reservation); 
		
		model.addAttribute("user", user);
		model.addAttribute("reservationClassInfo", reservationDetailInfo);
		return "/clish/myPage/myPage_reservation_detail";
	}

	//예약 수정페이지
	@GetMapping("/payment_info/change")
	public String reservationChangeForm(HttpSession session, Model model, ReservationDTO reservation, UserDTO user) {
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		user = myPageService.getUserInfo(user); // 예약자 정보
		Map<String,Object> reservationClassInfo = myPageService.reservationDetailInfo(reservation); 
		model.addAttribute("reservationClassInfo", reservationClassInfo);
		model.addAttribute("user",user);
		
		return "/clish/myPage/myPage_reservation_change";
	}
	
	// 폼 submit시 DTO에 주입할 데이터 변경[SQL : DATETIME -> DTO TIMESTAMP]
	@InitBinder
    public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Timestamp.class, new PropertyEditorSupport() {
            
            public void setAsText(String text) throws IllegalArgumentException {
                if (text == null || text.trim().isEmpty()) {
                    setValue(null);
                } else {
                    // "2025-07-13T12:38:10" → "2025-07-13 12:38:10"
                    String fixed = text.replace('T', ' ');
                    setValue(Timestamp.valueOf(fixed));
                }
            }
        });
    }
	
	//예약 수정 폼 submit시 수행
	@PostMapping("/payment_info/change")
	public String resrvationChange(ReservationDTO reservation) {
		System.out.println("수정완료페이지 : " + reservation.getReservationIdx());
		
		myPageService.changeReservation(reservation);
//		return "";
		return "redirect:/myPage/payment_info/detail?reservationIdx=" + reservation.getReservationIdx();
	}
	
	//---------------------------------------------------------------------------------------
	// 회원 탈퇴페이지
	@GetMapping("/withdraw")
	public String withdraw() {
		return "/clish/myPage/myPage_withdraw";
	}
	
	@PostMapping("/withdraw")
	public String withdrawForm(HttpSession session, UserDTO user, Model model) {
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		String inputPw = user.getUserPassword();
		user = myPageService.getUserInfo(user);
		if(user.getUserPassword().equals(inputPw)) {
			
			return "/clish/myPage/myPage_withdraw_withdrawResult";
		}
		model.addAttribute("msg","비밀번호 틀렸슴다");
		return "/commons/fail";
	}
	
	@PostMapping(value="/withdrawFinal", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String withdrawFinal(HttpSession session, UserDTO user) {
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		int withdrawResult = myPageService.withdraw(user);
		if(withdrawResult >0) {
			session.invalidate();
			return "탈퇴완료";
		} else {
			return "탈퇴실패 다시할것";
		}
	}
	
	// --------------------------------------------------------------------------------
	// 나의 문의
	@GetMapping("/myQuestion")
	public String myQuestion(HttpSession session, Model model, UserDTO user
			, @RequestParam(defaultValue = "1") int classQuestionPageNum
			, @RequestParam(defaultValue = "1") int inqueryPageNum) {
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		user = myPageService.getUserInfo(user); // 유저 정보 조회
		int listLimit = 5;
		int classQCount = myPageService.getclassQCount(user);
		if(classQCount > 0 ) {
			PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, classQCount, classQuestionPageNum, 3);
			
			if(classQuestionPageNum < 1 || classQuestionPageNum > pageInfoDTO.getMaxPage()) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "/myPage/myQuestion"); // 기본 페이지가 1페이지이므로 페이지 파라미터 불필요
				return "commons/result_process";
			}
			model.addAttribute("classQPageInfo", pageInfoDTO);

			List<InqueryDTO> classQDTOList = myPageService.getMyclassQ(pageInfoDTO.getStartRow(), listLimit, user);
			model.addAttribute("classQDTOList",classQDTOList);
			model.addAttribute("user", user);

		}
		// 사이트문의
		int inqueryCount = myPageService.getInqueryCount(user);
		if(inqueryCount > 0 ) {
			PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, inqueryCount, inqueryPageNum, 3);
			
			if(inqueryPageNum < 1 || inqueryPageNum > pageInfoDTO.getMaxPage()) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "/myPage/myQuestion"); // 기본 페이지가 1페이지이므로 페이지 파라미터 불필요
				return "commons/result_process";
			}
			model.addAttribute("inqueryPageInfo", pageInfoDTO);

			List<InqueryDTO> inqueryDTOList = myPageService.getMyInquery(pageInfoDTO.getStartRow(), listLimit, user);
			model.addAttribute("inqueryDTOList",inqueryDTOList);
			model.addAttribute("user", user);

		}
		
		
		return "/clish/myPage/myPage_question";
	}
	
	// 수정
	@GetMapping("/myQuestion/inquery/modify")
	public String inqueryModifyForm(InqueryDTO inqueryDTO, Model model, HttpSession session, UserDTO user) {
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		user = myPageService.getUserInfo(user); // 유저 정보 조회
		inqueryDTO = myPageService.getInqueryInfo(inqueryDTO);
		if(inqueryDTO.getInqueryType() == 1) {
			model.addAttribute("inqueryDTO", inqueryDTO);
		} else {
			inqueryDTO = myPageService.getclassQInfo(inqueryDTO);
			model.addAttribute("inqueryDTO", inqueryDTO);
		}
		model.addAttribute("user",user);
		return "/clish/myPage/myPage_question_inqueryForm";
	}
	
	@PostMapping("/myQuestion/inquery/modify")
	public String inqueryModify(InqueryDTO inqueryDTO, Model model, HttpSession session, UserDTO user) throws IOException {
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		user = myPageService.getUserInfo(user); // 유저 정보 조회
		InqueryDTO oriInqueryDTO = myPageService.getInqueryInfo(inqueryDTO);
		if (oriInqueryDTO.getInqueryStatus() == 1) {
			myPageService.modifyInquery(inqueryDTO);
		} else {
			model.addAttribute("msg","이 문의는 수정이 불가능한 상태입니다.");
			model.addAttribute("targetURL","/myPage/myQuestion");
			return "commons/result_process";
		}
//		inqueryDTO = myPageService.getInqueryInfo(inqueryDTO);
		
//		model.addAttribute("user",user);
//		model.addAttribute("inqueryDTO", inqueryDTO);
		return "redirect:/myPage/myQuestion";
//		return "";
	}
	
	// 삭제
	@PostMapping("/myQuestion/inquery/delete")
	public String inqueryDelete(InqueryDTO inqueryDTO) {
		
		myPageService.inqueryDelete(inqueryDTO);
		
		return "redirect:/myPage/myQuestion";
	}
	
	@GetMapping("/myQuestion/fileDelete")
	public String deleteFile(InqueryDTO inqueryDTO, FileDTO fileDTO) {
		
		myPageService.removeFile(fileDTO);
		
		return "redirect:/myPage/myQuestion/inquery/modify?inqueryIdx="+ inqueryDTO.getInqueryIdx();
	}
	
}









































