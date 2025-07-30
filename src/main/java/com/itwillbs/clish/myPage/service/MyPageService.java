package com.itwillbs.clish.myPage.service;

import java.io.IOException;
import java.sql.Date;
//import java.util.Date;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.clish.admin.dto.NotificationDTO;
import com.itwillbs.clish.admin.service.NotificationService;
import com.itwillbs.clish.common.file.FileDTO;
import com.itwillbs.clish.common.file.FileMapper;
import com.itwillbs.clish.common.file.FileUtils;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.myPage.dto.PaymentInfoDTO;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.myPage.dto.ReviewDTO;
import com.itwillbs.clish.myPage.mapper.MyPageMapper;
import com.itwillbs.clish.user.dto.UserDTO;
import com.itwillbs.clish.user.service.UserService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageService {
	private final MyPageMapper myPageMapper;
	private final FileMapper fileMapper;
	private final NotificationService notificationService;
	
	@Autowired
	private HttpSession session;
	//-----------------------------------------------------
	// 유저정보 불러오기
	public UserDTO getUserInfo(UserDTO user) {
		return myPageMapper.selectUserInfo(user);
	}
	
	// 유저정보 저장하기
	public int setUserInfo(UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.updateUserInfo(user);
	}
	
	// 예약정보리스트 불러오기
	public List<ReservationDTO> getReservationInfo(int startRow, int listLimit, UserDTO user) {
		//예약완료 후 2시간 지나면 예약 삭제
		//삭제해야할 예약 목록 리스트
		List<Map<String, Object>> toCancelList = myPageMapper.selectCancel(user);
		
		// 예약삭제, 알림 발송
		for(Map<String, Object> cancelList: toCancelList) {
			ReservationDTO reservationDTO = new ReservationDTO();
			// 삭제하는데 필요한 reservationIdx를 설정
			reservationDTO.setReservationIdx((String)cancelList.get("reservationIdx"));
			
			int deleteCount = myPageMapper.deleteReservation(reservationDTO);
			// 삭제한 예약이 있다면 알림 발송
			if(deleteCount > 0) {
				String userIdx = (String)cancelList.get("userIdx");
						
				// 알림 발송 메세지 작성
				String classTitle = (String)cancelList.get("classTitle");
//				System.out.println("강의명 : " + classTitle);
				String reservationMembers = cancelList.get("reservationMembers").toString();
//				System.out.println("예약인원 : " + reservationMembers);
				String reservationCom = ((LocalDateTime)cancelList.get("reservationCom")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
//				System.out.println("예약한시간 : " + reservationCom);
				String reservationClassDate = ((LocalDateTime)cancelList.get("reservationClassDate")).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
//				System.out.println("예약일 : " + reservationClassDate );
				notificationService.send(userIdx, 3, 
						reservationCom + "에 예약한 " + classTitle + "의 " + reservationClassDate + "수업 " + reservationMembers + "명 예약이 예약시간이 만료되어 자동으로 삭제됩니다" );
			}
		}
		// 삭제후 예약 목록 불러오기
		return myPageMapper.selectAllReservationInfo(startRow, listLimit, user);
	}
	
	public ReservationDTO getReservationInfo(ReservationDTO reservation) {
		return myPageMapper.selectOneReservationInfo(reservation);
	}

	public ClassDTO getClassInfo(ReservationDTO reservation) {
		return myPageMapper.selectOneClassInfo(reservation);
	}

	public int cancelReservation(ReservationDTO reservation) {
		return myPageMapper.deleteReservation(reservation);
	}
	
	public ReservationDTO reservationDetail(ReservationDTO reservation) {
		return myPageMapper.selectReservationDetail(reservation);
	}
	
	public Map<String, Object> reservationDetailInfo(ReservationDTO reservation) {
		return myPageMapper.ReservationDetailInfo(reservation);
	}

	public void changeReservation(ReservationDTO reservation) {
		myPageMapper.updateReservationInfo(reservation);
	}

	public List<PaymentInfoDTO> getPaymentList(int startRow, int listLimit, UserDTO user) {
		return myPageMapper.selectAllPaymentInfo(startRow, listLimit, user);
	}

	public int withdraw(UserDTO user) {
		return myPageMapper.withdraw(user);
	}

	public int getReservationCount(UserDTO user) {
		return myPageMapper.selectReservationCount(user);
	}

	public int getPaymentCount(UserDTO user) {
		return myPageMapper.selectPaymentCount(user);
	}

	public List<InqueryDTO> getMyInquery(int startRow, int listLimit, UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.selectAllInquery(startRow, listLimit, user);
	}
	
	@Transactional
	public void inqueryDelete(InqueryDTO inqueryDTO) {
		fileMapper.deleteAllFile(inqueryDTO.getInqueryIdx()); // FILE 테이블 내용 삭제
		myPageMapper.deleteInquery(inqueryDTO); // INQUERY 테이블 내용 삭제	
		
		List<FileDTO> fileDTOlist = fileMapper.selectAllFile(inqueryDTO.getInqueryIdx());
		FileUtils.deleteFiles(fileDTOlist, session); // idx와 같은 파일 다삭제
	}

	public InqueryDTO getInqueryInfo(InqueryDTO inqueryDTO) {
		return myPageMapper.selectOneInquery(inqueryDTO);
	}

	public int getInqueryCount(UserDTO user) {
		return myPageMapper.selectCountInquery(user);
	}
	
	public void modifyInquery(InqueryDTO inqueryDTO) throws IOException {
		myPageMapper.updateInquery(inqueryDTO);
		List<FileDTO> fileList = FileUtils.uploadFile(inqueryDTO, session);
		
		if(!fileList.isEmpty()) {
			fileMapper.insertFiles(fileList);
		}
	}

	public int getclassQCount(UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.selectCountClassQ(user);
	}

	public List<InqueryDTO> getMyclassQ(int startRow, int listLimit, UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.selectAllClassQ(startRow, listLimit, user);
	}


	public UserDTO checkRepName(UserDTO userDTO) {
		return myPageMapper.checkRepName(userDTO);
	}

	public UserDTO checkPhoneNumber(UserDTO userDTO) {
		// TODO Auto-generated method stub
		return myPageMapper.checkPhoneNumber(userDTO);
	}

	public List<NotificationDTO> selectNotification(int startRow, int listLimit, UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.selectAllNotification(startRow, listLimit, user);
	}

	public int getnotificationCount(UserDTO user) {
		
		return myPageMapper.selectCountNotification(user);
	}

	public int getUncompleteReviewCount(UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.selectUncompleteReviewCount(user);
	}

	public List<Map<String, Object>> getUncompleteReview(int startRow, int listLimit, UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.selectAllUncompleteReview(startRow, listLimit, user);
	}

	public Map<String, Object> getReservationClassInfo(ReservationDTO reservationDTO) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOneReservationClassInfo(reservationDTO);
	}
	
	public int getCompleteReviewCount(UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.selectCompleteReviewCount(user);
	}
	
	public List<ReviewDTO> getCompleteReview(int startRow, int listLimit, UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.selectAllCompleteReview(startRow, listLimit, user);
	}

	@Transactional
	public void writeReview(ReviewDTO review, UserDTO user) throws IOException {
		String userIdx = user.getUserIdx();
		String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
		review.setReviewIdx("rev_" + userIdx + "_" + now);
		
		myPageMapper.insertReview(review);
		
		List<FileDTO> fileList = FileUtils.uploadFile(review, session);
		
		if(!fileList.isEmpty()) {
			fileMapper.insertFiles(fileList);
		}
	}
	
	@Transactional
	public int deleteReview(ReviewDTO reviewDTO) {
		int delCount = myPageMapper.delteReview(reviewDTO);
		fileMapper.deleteAllFile(reviewDTO.getReviewIdx());
		
		List<FileDTO> fileDTOlist = fileMapper.selectAllFile(reviewDTO.getReviewIdx());
		FileUtils.deleteFiles(fileDTOlist, session); // idx와 같은 파일 다삭제
		
		return delCount;
	}

	public ReviewDTO getReviewInfo(ReviewDTO reviewDTO) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOneReview(reviewDTO);
	}
	
	@Transactional
	public void modifyReview(ReviewDTO reviewDTO) throws IOException {
		myPageMapper.updateReview(reviewDTO);
		
		List<FileDTO> fileList = FileUtils.uploadFile(reviewDTO, session);
		
		if(!fileList.isEmpty()) {
			fileMapper.insertFiles(fileList);
		}
	}

}
