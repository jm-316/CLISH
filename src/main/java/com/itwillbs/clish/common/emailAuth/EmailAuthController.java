package com.itwillbs.clish.common.emailAuth;

import lombok.RequiredArgsConstructor;

import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@Controller
@RequiredArgsConstructor
@RequestMapping("/email")
public class EmailAuthController {

    private final EmailAuthService emailAuthService;

    @PostMapping("/send")
    @ResponseBody
    public Map<String, Object> sendEmailAuth(@RequestBody EmailAuthDTO dto) {
    	Map<String, Object> res = new HashMap<>();
    	String token = emailAuthService.createAndSendToken(dto.getUserEmail(), dto.getPurpose());

    	if(token != null) {
			res.put("status", "이메일 발송 성공");
			res.put("token", token);
		} else {
			res.put("status", "이메일 발송 실패");
		}
    	
		return res;
    }

    @GetMapping("/verify")
    public String verifyToken(@RequestParam("token") String token, 
    		@RequestParam(value = "purpose", required = false) String purpose, Model model) {
        String result = emailAuthService.verifyToken(token, purpose);
        model.addAttribute("authResult", result);
        return "email/verify"; 
    }
    
    @GetMapping("/check")
    @ResponseBody
    public Map<String, Object> checkEmailAuth(@RequestParam String email) {
    	boolean verified = emailAuthService.isEmailVerified(email);

    	Map<String, Object> result = new HashMap<>();
    	result.put("verified", verified);
    	return result;
    }
}