<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이메일 인증 결과</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        h2 {
            color: ${result == 'true' ? '"green"' : '"red"'};
        }
    </style>
    <script>
        window.onload = () => {
            const result = '${result}';

            if (result === 'true') {
                // 부모 창에 인증 완료 메시지 전송
                window.opener.postMessage("emailVerified", "*");
            }

            // 2초 후 자동으로 창 닫기
            setTimeout(() => window.close(), 2000);
        };
    </script>
</head>
<body>
    <h2>
        <c:choose>
            <c:when test="${result == 'true'}">
                ✅ 이메일 인증이 완료되었습니다!
            </c:when>
            <c:otherwise>
                ❌ 인증에 실패했습니다. 다시 시도해주세요.
            </c:otherwise>
        </c:choose>
    </h2>
</body>
</html>