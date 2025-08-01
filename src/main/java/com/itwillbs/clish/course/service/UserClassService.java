package com.itwillbs.clish.course.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.course.mapper.UserClassMapper;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.myPage.dto.ReviewDTO;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserClassService {
	private final UserClassMapper userClassMapper;

	// 유저 정보 조회 요청
	public UserDTO getUserIdx(String userIdx) {
		return userClassMapper.selectUser(userIdx);
	}
	
	// 
	public int registReservation(ReservationDTO reservationDTO) {
		return userClassMapper.insertReservation(reservationDTO);
	}

	public List<ClassDTO> getClassList(int classType, String categoryIdx) {
		return userClassMapper.selectClass(classType, categoryIdx);
	}
	
	public List<ReviewDTO> getClassReview(int startRow, int listLimit, String classIdx) {
		return userClassMapper.selectAllClassReview(startRow, listLimit, classIdx);
	}

	public int getClassReviewCount(String classIdx) {
		return userClassMapper.selectCountClassReview(classIdx);
	}

	public int selectReservationMembers(String classIdx) {
		return userClassMapper.selectCountReservationMembers(classIdx);
	}


}
