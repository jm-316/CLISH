package com.itwillbs.clish.user.service;

import org.springframework.stereotype.Service;

import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;
import com.itwillbs.clish.user.mapper.UserMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
	
	private final UserMapper userMapper;

    public int registerCompanyUser(UserDTO userDTO, CompanyDTO companyDTO) {
        int userResult = userMapper.insertUser(userDTO);
        int companyResult = userMapper.insertCompany(companyDTO);
        return (userResult > 0 && companyResult > 0) ? 1 : 0;
    }

    public int registerGeneralUser(UserDTO userDTO) {
        return userMapper.insertUser(userDTO);
    }
    
    // 유저 정보 체크
	public UserDTO selectUserId(String userId) {
		return userMapper.selectUserId(userId);
	}
	
	// 닉네임 중복 체크
	public boolean isNickExists(String nickname) {
		return userMapper.countByNickname(nickname) > 0;
	}
	
	// 유저 아이디 중복 체크
	public boolean isUserIdExists(String userId) {
		 return userMapper.countByUserId(userId) > 0;
	}

	public boolean isUserPhoneExists(String userPhone) {
		return userMapper.countByUserPhoneMatch(userPhone) > 0;
	}


}