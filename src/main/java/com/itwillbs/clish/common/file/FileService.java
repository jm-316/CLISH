package com.itwillbs.clish.common.file;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.clish.myPage.mapper.MyPageMapper;
import com.itwillbs.clish.user.service.UserService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FileService {
	
	private final FileMapper fileMapper;

	@Autowired
	private HttpSession session;
	// ------------------------------------------------------
	public void removeFile(FileDTO fileDTO) {
		// TODO Auto-generated method stub
		fileDTO = fileMapper.selectFile(fileDTO);
		FileUtils.deleteFile(fileDTO, session);
		
		fileMapper.deleteFile(fileDTO);
	}
}
