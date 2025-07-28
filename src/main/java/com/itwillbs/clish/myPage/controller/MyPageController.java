package com.itwillbs.clish.myPage.controller;

import java.beans.PropertyEditorSupport;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.clish.admin.dto.NotificationDTO;
import com.itwillbs.clish.common.dto.PageInfoDTO;
import com.itwillbs.clish.common.file.FileDTO;
import com.itwillbs.clish.common.file.FileService;
import com.itwillbs.clish.common.utils.PageUtil;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.myPage.dto.PaymentInfoDTO;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.myPage.dto.ReviewDTO;
import com.itwillbs.clish.myPage.service.MyPageService;
import com.itwillbs.clish.user.dto.UserDTO;
import com.itwillbs.clish.user.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/myPage")
public class MyPageController {
	private final MyPageService myPageService;
	private final UserService userService;
	private final FileService fileService;
	
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
		
		if (user == null || !userService.matchesPassword(inputPw, user.getUserPassword())) {
			model.addAttribute("msg","비밀번호가 틀렸습니다.");
			model.addAttribute("targetUrl","myPage/change_user_info_form");
			return "commons/result_process";
	    }

		model.addAttribute("user", user);
		return "clish/myPage/myPage_change_user_info_form"; //비밀번호 일치시 이동페이지

		

	}
	
	@GetMapping("/check/repName")
	public ResponseEntity<Map<String, String>> checkRepName(UserDTO userDTO) {
		Map<String, String> response = new HashMap<>();
		
		UserDTO user = myPageService.checkRepName(userDTO);
		if(userService.isNickExists(userDTO.getUserRepName())) {
			
			if(user.getUserIdx().equals(userDTO.getUserIdx())) {
				System.out.println("idx일치");
				response.put("msg", "사용가능 닉네임");
				response.put("status", "success");
				response.put("repName", userDTO.getUserRepName());
				return ResponseEntity.ok(response);
			}
			
			response.put("msg", "사용불가능 닉네임");
			response.put("status", "fail");
			return ResponseEntity.ok(response);
		} else {
			response.put("msg", "사용가능 닉네임");
			response.put("status", "success");
			response.put("repName", userDTO.getUserRepName());
			return ResponseEntity.ok(response);
		}
	}
	
	@GetMapping("/check/userPhoneNumber")
	public ResponseEntity<Map<String, String>> checkPhoneNumber(UserDTO userDTO) {
		Map<String, String> response = new HashMap<>();
		
		UserDTO user = myPageService.checkPhoneNumber(userDTO);
		if(userService.isUserPhoneExists(userDTO.getUserPhoneNumber())) {
			
			if(user.getUserIdx().equals(userDTO.getUserIdx())) {
				System.out.println("idx일치");
				response.put("msg", "사용가능 번호");
				response.put("status", "success");
				return ResponseEntity.ok(response);
			}
			
			response.put("msg", "사용불가능 번호");
			response.put("status", "fail");
			return ResponseEntity.ok(response);
		} else {
			response.put("msg", "사용가능 번호");
			response.put("status", "success");
			return ResponseEntity.ok(response);
		}
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
			user.setUserPassword(userService.encodePassword(new_password));
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
				model.addAttribute("targetURL", "/myPage/payment_info"); 
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
				model.addAttribute("targetURL", "/myPage/payment_info"); 
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
		
		if (user == null || !userService.matchesPassword(inputPw, user.getUserPassword())) {
			model.addAttribute("msg","비밀번호가 틀렸습니다.");
			return "/commons/fail";
	    }
		
		return "/clish/myPage/myPage_withdraw_withdrawResult";
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
				model.addAttribute("targetURL", "/myPage/myQuestion");
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
				model.addAttribute("targetURL", "/myPage/myQuestion"); 
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

		return "redirect:/myPage/myQuestion";
	}
	
	// 삭제
	@PostMapping("/myQuestion/inquery/delete")
	public String inqueryDelete(InqueryDTO inqueryDTO) {
		
		myPageService.inqueryDelete(inqueryDTO);
		
		return "redirect:/myPage/myQuestion";
	}
	
	@GetMapping("/myQuestion/fileDelete")
	public String deleteFile(InqueryDTO inqueryDTO, FileDTO fileDTO) {
		fileService.removeFile(fileDTO);
		return "redirect:/myPage/myQuestion/inquery/modify?inqueryIdx="+ inqueryDTO.getInqueryIdx();
	}
	//------------------------------------------------------------------------------------------------------------------
	// 알림전체보기
	@GetMapping("/notification")
	public String notification(HttpSession session, UserDTO user, Model model
			, @RequestParam(defaultValue = "1") int notificationPageNum) {
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		user = myPageService.getUserInfo(user);
		int listLimit = 10;
		int notificationListCount = myPageService.getnotificationCount(user);
		if(notificationListCount > 0) {
		
			PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, notificationListCount, notificationPageNum, 3);
			
			if(notificationPageNum < 1 || notificationPageNum > pageInfoDTO.getMaxPage()) {
				model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
				model.addAttribute("targetURL", "/myPage/payment_info"); 
				return "commons/result_process";
			}
			
			model.addAttribute("notificationPageInfo", pageInfoDTO);

			List<NotificationDTO> notificationList = myPageService.selectNotification(pageInfoDTO.getStartRow(), listLimit, user);
			model.addAttribute("notificationList",notificationList);
		}
		return "/clish/myPage/myPage_notification";
	}
	// ------------------------------------------------------------------------------------------------------------
	// 후기 관리
	@GetMapping("/myReview")
	public String myReview(Model model,HttpSession session, UserDTO user,
			@RequestParam(defaultValue = "0") int reviewCom,
			@RequestParam(defaultValue = "1") int reviewPageNum) {
		String id = (String)session.getAttribute("sId");
		user.setUserId(id);
		user = myPageService.getUserInfo(user);
		int listLimit = 5;
		
		if(reviewCom == 0) {
			int reviewListCount = myPageService.getUncompleteReviewCount(user);
			
			if(reviewListCount > 0) {
				PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, reviewListCount, reviewPageNum, 3);
				
				if(reviewPageNum < 1 || reviewPageNum > pageInfoDTO.getMaxPage()) {
					model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
					model.addAttribute("targetURL", "/myPage/myReview"); 
					return "commons/result_process";
				}
				
				model.addAttribute("pageInfo",pageInfoDTO);
				
				List<Map<String, Object>> uncompleteReviewList = myPageService.getUncompleteReview(pageInfoDTO.getStartRow(), listLimit, user);
				
				model.addAttribute("reviewInfo",uncompleteReviewList);
				
			} 
		} else {
			int reviewListCount = myPageService.getCompleteReviewCount(user);
			
			if(reviewListCount > 0) {
				
				PageInfoDTO pageInfoDTO = PageUtil.paging(listLimit, reviewListCount, reviewPageNum, 3);
				if(reviewPageNum < 1 || reviewPageNum > pageInfoDTO.getMaxPage()) {
					model.addAttribute("msg", "해당 페이지는 존재하지 않습니다!");
					model.addAttribute("targetURL", "/myPage/myReview"); 
					return "commons/result_process";
				}
				
				model.addAttribute("pageInfo",pageInfoDTO);
				
				List<ReviewDTO> completeReviewList = myPageService.getCompleteReview(pageInfoDTO.getStartRow(), listLimit, user);
				
				model.addAttribute("reviewInfo",completeReviewList);

			} 
		}
		
	    model.addAttribute("reviewPageNum", reviewPageNum);
	    model.addAttribute("reviewCom", reviewCom);
	    
		return "/clish/myPage/myPage_myReview";
	}
	
	//수강후기 작성페이지
	@GetMapping("/myReview/writeReviewForm")
	public String writeReviewForm(ReservationDTO reservationDTO, HttpSession session, UserDTO user, Model model) {
		
		Map<String, Object> reservationClassInfo = myPageService.getReservationClassInfo(reservationDTO);
		
		model.addAttribute("reservationClassInfo",reservationClassInfo);
		return "/clish/myPage/myPage_myReview_writeReviewForm";
	}
	
	// 수강후기 작성완료처리
	@PostMapping("/myReview/writeReview")
	public String writeReview(ReviewDTO review, HttpSession session) throws IOException {
		String id = (String)session.getAttribute("sId");
		UserDTO user = new UserDTO();
		user.setUserId(id);
		user = myPageService.getUserInfo(user);
		myPageService.writeReview(review, user);
		return "redirect:/myPage/myReview";
	}
	
	// 작성된 후기 삭제
	@ResponseBody
	@PostMapping("/myReview/deleteReview")
	public Map<String, Object> deleteReview(ReviewDTO reviewDTO) {
		Map<String,Object> result = new HashMap<>();
		
		int delCount = myPageService.deleteReview(reviewDTO);
		
		if (delCount > 0) {
			result.put("msg", "후기 삭제 완료.");
		} else {
			result.put("msg", "삭제 실패");
		}
		
		return result;
	}
	
	// 작성된 후기 수정
	@GetMapping("/myReview/modifyReviewForm")
	public String modifyReviewForm(ReviewDTO reviewDTO, Model model) {
		reviewDTO = myPageService.getReviewInfo(reviewDTO);
		
		model.addAttribute("reviewDTO", reviewDTO);
		System.out.println(reviewDTO);
		return "/clish/myPage/myPage_myReview_modifyReviewForm";
	}
	
	@GetMapping("myReview/removeFile")
	public String removeFile(FileDTO fileDTO, ReviewDTO reviewDTO) {
		fileService.removeFile(fileDTO);
		return "redirect:/myPage/myReview/modifyReviewForm?reviewIdx="+ reviewDTO.getReviewIdx();
	}
	
	@PostMapping("/myReview/modifyReview")
	public String modifyReview(ReviewDTO reviewDTO, Model model) throws IOException {
		
		myPageService.modifyReview(reviewDTO);
		
		return "redirect:/myPage/myReview";
	}
	
	
}









































