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

    // 1️⃣ 이메일 인증 요청 (AJAX POST)
    @PostMapping("/send")
    @ResponseBody
    public String sendEmailAuth(@RequestBody EmailAuthDTO dto) {
        String token = emailAuthService.createAndSendToken(dto.getUserEmail());

        return token != null ? token : "";
    }

    // 2️⃣ 이메일 링크 클릭 → 인증 확인 페이지로 이동
    @GetMapping("/verify")
    public String verifyToken(@RequestParam("token") String token, Model model) {
        boolean result = emailAuthService.verifyToken(token); // DB에서 is_verified = 1 처리
        model.addAttribute("authResult", result);
        return "email/verify"; // verify.jsp로 이동
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