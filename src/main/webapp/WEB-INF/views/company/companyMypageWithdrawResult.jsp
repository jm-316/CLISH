<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴 결과</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/top.css">
</head>
<body>

	<!-- 공통 헤더 -->
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<c:choose>
		<c:when test="${msg eq '탈퇴완료'}">
			<script>
				alert("탈퇴가 완료되었습니다.");
				location.href = "${pageContext.request.contextPath}/main";
			</script>
		</c:when>
		<c:otherwise>
			<script>
				alert("탈퇴에 실패했습니다. 다시 시도해주세요.");
				history.back(); // 이전 페이지(비밀번호 입력 폼)로 돌아감
			</script>
		</c:otherwise>
	</c:choose>
	
	<!-- 공통 푸터 -->
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	
</body>
</html>