package com.itwillbs.clish.myPage.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class InqueryDTO {
	private String inqueryIdx;
	private String userIdx;
	private String inqueryTitle;
	private String inqueryDetail;
	private String inqueryAnswer;
	private String classIdx;
	private int inqueryType;
	private Timestamp inqueryDatetime;
	private Timestamp inqueryAnswerDatetime;
	private Timestamp inqueryModifyDatetime;
	private int inqueryStatus;
	private String classTitle;
	
}
