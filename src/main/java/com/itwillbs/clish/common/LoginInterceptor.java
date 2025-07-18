package com.itwillbs.clish.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession httpSession = request.getSession(false);
		
		if (httpSession == null || httpSession.getAttribute("sUT") == null || httpSession.getAttribute("sId") == null) {
			return denyAccess(request, response, "접근권한이 없습니다.", "/user/login");
		}
		
		Integer userType = (Integer) httpSession.getAttribute("sUT");
		String uri = request.getRequestURI();
		
		if (uri.startsWith("/admin") && userType != 3) {
			return denyAccess(request, response, "관리자만 접근 가능한 페이지입니다.", "/");
		}
		
		if (uri.startsWith("/company") && userType != 2) {
			return denyAccess(request, response, "접근권한이 없습니다.", "/");
		}
		
		if (uri.startsWith("/myPage") && userType != 1) {
			return denyAccess(request, response, "접근권한이 없습니다.", "/");
		}
		
		return true;
	}
	
	private boolean denyAccess(HttpServletRequest request, HttpServletResponse response, String msg, String targetUrl) throws ServletException, IOException {
		request.setAttribute("msg", msg);
		request.setAttribute("targetURL", targetUrl);
		request.getRequestDispatcher("/WEB-INF/views/commons/result_process.jsp").forward(request, response);
		return false;
	}
	
}
