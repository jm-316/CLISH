package com.itwillbs.clish.myPage.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
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
	private LocalDate reservationClassDate;
	private LocalDateTime reservationCom;
	private String classIdx;
	private int reservationStatus;
	
}