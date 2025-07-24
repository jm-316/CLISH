package com.itwillbs.clish.admin.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DashboardSummaryDTO {
	private int userCount;
	private int companyCount;
	private int pendingClassCount;
	private int pendingCompanyCount;
	private int unAnsweredInquiryCount;
}
