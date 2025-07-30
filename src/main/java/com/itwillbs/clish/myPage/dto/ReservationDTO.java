package com.itwillbs.clish.myPage.dto;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ReservationDTO {
	private String reservationIdx; 
	private String userIdx;
	private int reservationMembers;
	
//	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private LocalDate reservationClassDate;
	
	private LocalDateTime reservationCom;
	private String classIdx;
	private int reservationStatus;
	
}