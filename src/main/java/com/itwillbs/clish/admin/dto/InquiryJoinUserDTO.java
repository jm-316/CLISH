package com.itwillbs.clish.admin.dto;

import com.itwillbs.clish.myPage.dto.InqueryDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InquiryJoinUserDTO {
	private InqueryDTO inquiry;
	private String classIdx;
	private int inqueryType;
	private String userName;
}
