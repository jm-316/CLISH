<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% Boolean result = (Boolean) request.getAttribute("authResult");
   if (result == null) result = false; %>
<!DOCTYPE html>
<html>
<head>
    <title>이메일 인증</title>
</head>
<body>
    <div style="text-align: center; margin-top: 100px;">
        <% if (result) { %>
            <h2 style="color: green;">이메일 인증에 성공했습니다.</h2>
			<script>
				if (window.opener && typeof window.opener.setEmailVerified === "function") {
				    window.opener.setEmailVerified();
				}			
				setTimeout(() => window.close(), 1500);
			</script>
        <% } else { %>
            <h2 style="color: red;">인증에 실패했거나, 링크가 만료되었습니다.</h2>
            <p>다시 인증을 요청해주세요.</p>
        <% } %>
    </div>
</body>
</html>
