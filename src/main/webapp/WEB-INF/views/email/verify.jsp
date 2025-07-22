<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String msg = (String) request.getAttribute("authResult"); %>
<!DOCTYPE html>
<html>
<head>
    <title>이메일 인증</title>
</head>
<body>
    <div style="text-align: center; margin-top: 100px;">
        <h2>
            <%= msg != null ? msg : "인증에 실패했거나, 링크가 만료되었습니다." %>
        </h2>
        <% if(msg != null && msg.contains("성공") || (msg != null && msg.contains("완료"))) { %>
			<script>
				if(window.opener && typeof window.opener.setEmailVerified === "function") {
				    window.opener.setEmailVerified();
				}			
			</script>
        <% } %>
        <script>
            setTimeout(() => window.close(), 1500);
        </script>
    </div>
</body>	
</html>
