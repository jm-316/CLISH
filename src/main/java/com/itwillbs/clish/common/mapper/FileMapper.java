package com.itwillbs.clish.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.clish.common.dto.FileDTO;
@Mapper
public interface FileMapper {

	FileDTO selectFile(FileDTO fileDTO);

	void deleteFile(FileDTO fileDTO);

	void insertFiles(List<FileDTO> fileList);

}
