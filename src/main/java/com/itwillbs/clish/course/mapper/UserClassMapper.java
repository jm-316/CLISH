package com.itwillbs.clish.course.mapper;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.myPage.dto.ReviewDTO;
import com.itwillbs.clish.user.dto.UserDTO;

@Mapper
public interface UserClassMapper {

	UserDTO selectUser(String userIdx);

	int insertReservation(ReservationDTO reservationDTO);

	List<ClassDTO> selectClass(@Param("classType")int classType, @Param("categoryIdx")String categoryIdx);
	
	List<ReviewDTO> selectAllClassReview(@Param("startRow")int startRow, @Param("listLimit")int listLimit,@Param("classIdx")String classIdx);

	int selectCountClassReview(String classIdx);

	// 총 예약인원을 알기 위한 SELECT
	int selectCountReservationMembers(String classIdx);


}
