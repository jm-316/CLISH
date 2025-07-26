package com.itwillbs.clish.common.file;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.clish.myPage.dto.InqueryDTO;
@Mapper
public interface FileMapper {

	FileDTO selectFile(FileDTO fileDTO);

	void deleteFile(FileDTO fileDTO);

	void insertFiles(List<FileDTO> fileList);

	List<FileDTO> selectAllFile(String idx);

	void deleteAllFile(String idx);


}
