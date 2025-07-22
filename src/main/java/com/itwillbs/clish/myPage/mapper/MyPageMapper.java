package com.itwillbs.clish.myPage.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.clish.course.dto.ClassDTO;
import com.itwillbs.clish.myPage.dto.InqueryDTO;
import com.itwillbs.clish.myPage.dto.PaymentInfoDTO;
import com.itwillbs.clish.myPage.dto.ReservationDTO;
import com.itwillbs.clish.user.dto.UserDTO;


@Mapper
public interface MyPageMapper {

	UserDTO selectUserInfo(UserDTO user);

	int updateUserInfo(UserDTO user);

	List<ReservationDTO> selectAllReservationInfo(@Param("startRow")int startRow,@Param("listLimit")int listLimit,@Param("user")UserDTO user);

	ReservationDTO selectOneReservationInfo(ReservationDTO reservation);

	ClassDTO selectOneClassInfo(ReservationDTO reservation);

	Map<String, Object> ReservationDetailInfo(ReservationDTO reservation);

	int deleteReservation(ReservationDTO reservation);

	ReservationDTO selectReservationDetail(ReservationDTO reservation);

	void updateReservationInfo(ReservationDTO reservation);

	List<PaymentInfoDTO> selectAllPaymentInfo(@Param("startRow")int startRow,@Param("listLimit")int listLimit, @Param("user")UserDTO user);

	int withdraw(UserDTO user);

	int selectReservationCount(UserDTO user);

	int selectPaymentCount(UserDTO user);

	List<InqueryDTO> selectAllInquery(@Param("startRow")int startRow, @Param("listLimit")int listLimit, @Param("user")UserDTO user);

	void deleteInquery(InqueryDTO inqueryDTO);

	InqueryDTO selectOneInquery(InqueryDTO inqueryDTO);

	int selectCountInquery(UserDTO user);

	void updateInquery(InqueryDTO inqueryDTO);




}