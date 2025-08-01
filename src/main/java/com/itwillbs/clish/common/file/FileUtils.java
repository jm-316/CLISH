package com.itwillbs.clish.common.file;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.clish.myPage.dto.InqueryDTO;

public class FileUtils {
	
	private static String uploadPath = "/usr/local/tomcat/upload";
	
	// 서브디렉토리 생성
	public static String createDirectories(String path) {

		LocalDate localDateNow = LocalDate.now();

		String datePattern = "yyyy/MM/dd";
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);

		String subDir = localDateNow.format(dtf);

		path += "/" + subDir;

		try {
			Files.createDirectories(Paths.get(path));
		} catch (IOException e) {
			System.out.println("서브 디렉토리 생성 실패 - " + path);
			e.printStackTrace();
		}
		
		return subDir;
	}
	
	
	// 파일업로드 인터페이스
	public interface FileUploadHelpper{
		MultipartFile[] getFiles();
		String getIdx();
	}
	
	// 파일 업로드
	public static List<FileDTO> uploadFile(FileUploadHelpper help, HttpSession session) throws IllegalStateException, IOException {
		String subDir = ""; // 서브디렉토리명을 저장할 변수 선언
		System.out.println("업로드 패스 : " + uploadPath);
		// --------------------------------------------------------
		// 프로젝트 상의 가상의 업로드 경로를 사용할 경우 추가 작업
		String realPath = session.getServletContext().getRealPath(uploadPath);
		System.out.println("리얼 패스 : " + realPath);
		
		subDir = FileUtils.createDirectories(realPath);
		
		// 업로드 경로와 서브 디렉토리 결합
		String destinationPath = realPath + "/" + subDir;

		List<FileDTO> fileList = new ArrayList<FileDTO>(); // 파일 정보들을 저장할 List 객체 생성
		
		for(MultipartFile mFile : help.getFiles()) {
			// 파일이 존재할 경우 실제 업로드 처리 및 BoardFileDTO 객체에 정보 저장
			if(!mFile.isEmpty()) {
				String originalFileName = mFile.getOriginalFilename();
	
				String uuid = UUID.randomUUID().toString();
				String realFileName = uuid + "_" + originalFileName;

				File destinationFile = new File(destinationPath, realFileName);
				
				mFile.transferTo(destinationFile);

				FileDTO fileDTO = new FileDTO();
				fileDTO.setIdx(help.getIdx());
				fileDTO.setOriginalFileName(originalFileName);
				fileDTO.setRealFileName(realFileName);
				fileDTO.setSubDir(subDir);
				fileDTO.setFileSize(mFile.getSize());
				fileDTO.setContentType(mFile.getContentType());
				
				fileList.add(fileDTO);
				System.out.println("데스티네이션 path=" + destinationFile.getAbsolutePath());
			}
		} 
		return fileList;
	}
	
	//파일 삭제
	public static void deleteFile(FileDTO fileDTO, HttpSession session) {

		String realPath = session.getServletContext().getRealPath(uploadPath);
		
		Path path = Paths.get(realPath, fileDTO.getSubDir(), fileDTO.getRealFileName());

		try {
			Files.deleteIfExists(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 다중 파일 삭제
	public static void deleteFiles(List<FileDTO> fileList, HttpSession session) {
		
		for(FileDTO fileDTO : fileList) {
			FileUtils.deleteFile(fileDTO, session);
		}	
	}
	
	
}
