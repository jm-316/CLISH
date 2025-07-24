package com.itwillbs.clish.admin.mapper;

import java.util.List;

import com.itwillbs.clish.admin.dto.CategoryRevenueDTO;
import com.itwillbs.clish.admin.dto.RevenueDTO;

public interface AdminDashboardMapper {

	int selectUserCount();

	int selectCompanyCount();

	int selectPendingClassCount();

	int selectPendingCompanyCount();

	int selectUnAnsweredInquiryCount();
	
	List<RevenueDTO> selectDailyRevenue();

	List<RevenueDTO> selectMonthlyRevenue();

	List<CategoryRevenueDTO> selectCategoryRevenue();


}
