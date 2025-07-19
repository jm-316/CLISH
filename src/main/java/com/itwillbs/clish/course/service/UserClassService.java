package com.itwillbs.clish.course.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.course.mapper.UserClassMapper;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.user.dto.UserDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserClassService {
	private final UserClassMapper userClassMapper;

	public UserDTO getUserIdx(String userIdx) {
		return userClassMapper.selectUser(userIdx);
	}

	public int registReservation(ReservationDTO reservationDTO) {
		return userClassMapper.insertReservation(reservationDTO);
	}

	public List<ClassDTO> getClassList(int classType, String categoryIdx) {
		// TODO Auto-generated method stub
		return userClassMapper.selectClass(classType, categoryIdx);
	}


}
