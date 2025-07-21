package com.itwillbs.clish.admin.dto;

import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;

@Getter
@Setter
@ToString
public class SupportDTO {
	private String supportIdx;
	private String supportTitle;
	private String supportDetail;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate supportCreatedAt;
	private String supportCategory;
	private String supportAttach;
}
