package com.itwillbs.clish.common.emailAuth;

import java.time.LocalDateTime;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmailAuthService {
	
	@Value("${app.base-url}")
	private String baseUrl;

    private final EmailAuthMapper emailAuthMapper;
    private final EmailClient emailClient;

    @Transactional
    public String createAndSendToken(String email) {

    	String token = UUID.randomUUID().toString();
        LocalDateTime expire = LocalDateTime.now().plusMinutes(10);

        EmailAuthDTO dto = new EmailAuthDTO();
        dto.setUserEmail(email);
        dto.setUserEmailToken(token);
        dto.setUserEmailTokenExpire(expire);
        dto.setUserEmailAuthYn("N");

        EmailAuthDTO existing = emailAuthMapper.selectByEmail(email);

        int result = 0;

        if(existing == null) {
            result = emailAuthMapper.insertEmailAuth(dto);
        } else {
            result = emailAuthMapper.updateEmailAuth(dto);
        }

        if(result > 0) {
        	
            String subject = "[CLISH] 이메일 인증 요청";
            String verifyLink = baseUrl + "/email/verify?token=" + token;
            String content = "<h3>아래 링크를 클릭하여 이메일 인증을 완료해주세요.</h3>"
                           + "<a href='" + verifyLink + "'>이메일 인증하기</a>"
                           + "<p>(유효시간: 10분)</p>";

            emailClient.sendMail(email, subject, content);
            return token;
        }

        return null;
    }

    @Transactional
    public boolean verifyToken(String token) {
        EmailAuthDTO auth = emailAuthMapper.selectByToken(token);

        if(auth == null) return false;
        if("Y".equals(auth.getUserEmailAuthYn())) return false;
        if(auth.getUserEmailTokenExpire().isBefore(LocalDateTime.now())) return false;

        emailAuthMapper.updateAuthYn(auth.getUserEmail());
        return true;
    }


    public boolean isEmailVerified(String email) {                 
        Boolean isVerified = emailAuthMapper.emailAuthYN(email);
        return Boolean.TRUE.equals(isVerified);
    }
}
