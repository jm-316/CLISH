package com.itwillbs.clish.myPage.service;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.clish.common.dto.FileDTO;
import com.itwillbs.clish.common.mapper.FileMapper;
import com.itwillbs.clish.common.utils.FileUtils;
import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.myPage.dto.PaymentInfoDTO;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.myPage.mapper.MyPageMapper;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageService {
	private final MyPageMapper myPageMapper;
	private final FileMapper fileMapper;
	@Autowired
	private HttpSession session;
	//-----------------------------------------------------
	public UserDTO getUserInfo(UserDTO user) {
		return myPageMapper.selectUserInfo(user);
	}
	
	public int setUserInfo(UserDTO user) {
		// TODO Auto-generated method stub
		return myPageMapper.updateUserInfo(user);
	}
	
	public List<ReservationDTO> getReservationInfo(int startRow, int listLimit, UserDTO user) {
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

	public void inqueryDelete(InqueryDTO inqueryDTO) {
		myPageMapper.deleteInquery(inqueryDTO);
		
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

	public InqueryDTO getclassQInfo(InqueryDTO inqueryDTO) {
		// TODO Auto-generated method stub
		return myPageMapper.selectOneClassQ(inqueryDTO);
	}

	public void removeFile(FileDTO fileDTO) {
		// TODO Auto-generated method stub
		fileDTO = fileMapper.selectFile(fileDTO);
		FileUtils.deleteFile(fileDTO, session);
		
		fileMapper.deleteFile(fileDTO);
	}
	



}
