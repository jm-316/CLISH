package com.itwillbs.clish.admin.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InquiryDTO {
	private String inqueryIdx;
	private String userIdx;
	private String inqueryTitle;
	private String inqueryDetail;
	private String inqueryAnswer;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate inqueryDateTime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate inqueryAnswerDateTime;
	
	private int inqueryStatus;
	private int inqueryType;
}
