package com.itwillbs.clish.user.mapper;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;

public interface UserMapper {

	int insertUser(UserDTO userDTO);

	int insertCompany(CompanyDTO companyDTO);

	UserDTO selectUserId(String userId);
	
	boolean existsByEmail(String email);

	int countByNickname(@Param("nickname") String nickname);

	int countByUserId(@Param("userId") String userId);

}
