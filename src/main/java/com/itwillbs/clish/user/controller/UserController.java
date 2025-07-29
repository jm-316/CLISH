package com.itwillbs.clish.user.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.clish.user.dto.CompanyDTO;
import com.itwillbs.clish.user.dto.UserDTO;
import com.itwillbs.clish.user.service.UserService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
	
	private final UserService userService;
	private static final String UPLOAD_DIR = "src/main/webapp/resources/upload/biz";
	
	//회원가입
	@GetMapping("/join")
	public String showJoinTypePage() {
	    return "/user/join_way";
	}
	
	//일반-기업 분류 회원가입
	@GetMapping("/join/form")
	public String joinForm(HttpSession session, @RequestParam(required = false) String from) {
	    if("general".equals(from)) {
	        session.setAttribute("userType", 1);
	    } else if("company".equals(from)) {
	        session.setAttribute("userType", 2);
	    }
	    return "user/join_form";
	}
	
	// 회원가입 완료
	@PostMapping("/register")
	public String processJoin( 
			@ModelAttribute UserDTO userDTO,
	        @RequestParam(value = "bizFile", required = false) MultipartFile bizFileName,
	        @RequestParam(value = "bizRegNo", required = false) String bizRegNo,
	        RedirectAttributes redirect) {

	    String prefix = (userDTO.getUserType() == 1) ? "user" : "comp";
	    String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
	    String userIdx = prefix + now;
	    userDTO.setUserIdx(userIdx);

	    CompanyDTO companyDTO = null;
	    if(userDTO.getUserType() == 2) {
	        companyDTO = new CompanyDTO();
	        companyDTO.setUserIdx(userIdx);
	        companyDTO.setBizRegNo(bizRegNo);

	        try {
	            File uploadDir = new File(UPLOAD_DIR);
	            if(!uploadDir.exists()) {
	                uploadDir.mkdirs();
	            }
	            String originalFilename = bizFileName.getOriginalFilename();
	            String uuid = UUID.randomUUID().toString();
	            String newFilename = uuid + "_" + originalFilename;
	            File destFile = new File(uploadDir, newFilename);
	            
	            bizFileName.transferTo(destFile);
	            companyDTO.setBizFileName(newFilename); 
	            companyDTO.setBizFilePath("/resources/upload/biz/" + newFilename); 
	            // /usr/local/tomcat/webapps/upload/biz/
	            // /c5d2504t1p1.itwillbs.com:8080/upload
	        } catch (IOException e) {
	            redirect.addFlashAttribute("errorMsg", "기업 회원가입 실패 - 파일 저장 오류");
	            return "redirect:/user/join/form";
	        }
	    }

	    int result = (userDTO.getUserType() == 2)
	        ? userService.registerCompanyUser(userDTO, companyDTO)
	        : userService.registerGeneralUser(userDTO);

	    if(result > 0) {
	        return "redirect:/user/join_success";
	    } else {
	        redirect.addFlashAttribute("errorMsg", "회원가입 실패");
	        return "redirect:/commons/fail";
	    }
	}
	
	@GetMapping("/join_success")
	public String joinSuccess() {
		return "/user/join_success";
	}
	
	@GetMapping("/login")
	public String showLoginForm(HttpServletRequest request, HttpSession session) {
		String lastAddress =  request.getHeader("Referer");
		// 세션에 로그인 클릭한 페이지 저장
		session.setAttribute("lastAddress", lastAddress);
		
	    return "user/login_form";
	}
	
	@PostMapping("/login")
	public String login(
	        @ModelAttribute UserDTO userDTO,
	        @RequestParam(value = "rememberId", required = false) String rememberId,
	        HttpServletResponse response, HttpSession session, RedirectAttributes redirect) {
	    
	    UserDTO dbUser = userService.selectUserId(userDTO.getUserId());
	    String lastAddress = (String) session.getAttribute("lastAddress");
	    
	    if (dbUser == null || !userService.matchesPassword(userDTO.getUserPassword(), dbUser.getUserPassword())) {
	        redirect.addFlashAttribute("errorMsg", "비밀번호 불일치");
	        return "redirect:/user/login";
	    }

	    if(Objects.equals(dbUser.getUserStatus(), 3)) {
	        redirect.addFlashAttribute("errorMsg", "탈퇴한 회원입니다.");
	        return "redirect:/user/login";
	    }

	    session.setAttribute("sUT", dbUser.getUserType());
	    session.setAttribute("sId", dbUser.getUserId());
	    session.setAttribute("sIdx", dbUser.getUserIdx());
	    session.setAttribute("loginUser", dbUser);
	    session.setMaxInactiveInterval(60 * 60 * 24);

	    Cookie cookie = new Cookie("rememberId", dbUser.getUserId());
	    cookie.setPath("/");
	    if(rememberId != null) {
	        cookie.setMaxAge(60 * 60 * 24 * 30); 
	    } else {
	        cookie.setMaxAge(0);
	    }
	    response.addCookie(cookie);

	    return "redirect:" + lastAddress;
	}
	
	
	
//	@PostMapping("/saveEmailSession")
//	public String saveEmailSession(@RequestParam("user_email") String userEmail,
//	                               HttpSession session, RedirectAttributes redirect) {
//	    session.setAttribute("user_email", userEmail);
//	    redirect.addFlashAttribute("authMsg", "======");
//	    return "redirect:/member/general_join";
//	}
	
	@GetMapping("/checkNname")
	@ResponseBody
	public Map<String, Boolean> checkNickname(@RequestParam String nickname) {
	    boolean nickExists = userService.isNickExists(nickname);
	    Map<String, Boolean> result = new HashMap<>();
	    result.put("exists", nickExists);
	    return result;
	}
	
	@GetMapping("/checkId")
	@ResponseBody
	public Map<String, Boolean> checkId(@RequestParam String userId) {
	    boolean idExists = userService.isUserIdExists(userId);
	    Map<String, Boolean> result = new HashMap<>();
	    result.put("exists", idExists);
	    return result;
	}
	
	@GetMapping("/checkPhone")
	@ResponseBody
	public Map<String, Boolean> checkPhone(@RequestParam String userPhone) {
	    boolean phoneExists = userService.isUserPhoneExists(userPhone);
	    Map<String, Boolean> result = new HashMap<>();
	    result.put("exists", phoneExists);
	    return result;
	}
}
