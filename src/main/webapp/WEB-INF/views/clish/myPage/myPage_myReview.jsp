<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com" >
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Nanum+Myeongjo&family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Orelega+One&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" >
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<style type="text/css">
	.reviewbar-container {
	  display: flex;
	  justify-content: flex-start;
	  gap: 8px; /* 버튼 사이 간격 */
	}
	.reviewbar {
	  background: #f6f7fb;        /* 밝은 배경 */
	  border: none;               /* 테두리 없음 */
	  border-radius: 10px;        /* 둥근 모서리 */
	  padding: 12px 26px;         /* 넉넉한 여백 */
	  font-size: 16px;
	  font-weight: 600;
	  margin-right: 8px;          /* 버튼 사이 간격 */
	  color: #222;                /* 글씨 색 */
	  box-shadow: 0 1px 3px rgba(0,0,0,.04);
	  cursor: pointer;
	  transition: background 0.2s, color 0.2s;
	}
	.reviewbar:hover, .reviewbar:focus {
	  background: #2478ff;        /* 마우스 올렸을 때 파란색 */
	  color: #fff;                /* 글씨 흰색 */
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<main id="container">
	
	<jsp:include page="/WEB-INF/views/clish/myPage/side.jsp"></jsp:include>
	<div id="main">
		<h1>${sessionScope.sId}님 수강 후기 관리</h1>
		<div class="reviewbar-container">
		<input type="button" class="reviewbar" value="작성 가능 수강후기">
		<input type="button" class="reviewbar" value="작성 한 수강후기">
		</div>
		<div>
			<table>
				<tr>
					<th rowspan="2">이미지</th>
					<th>수강 강의</th>
					<th>수강일</th>
					<td rowspan="2">
						<input type="button" value="강의 상세 페이지"><br><br>
						<input type="button" value="수강후기쓰러가기">
					</td>
				</tr>
				<tr>
					<td>너무하기싫네요</td>
					<td>2025.07.11</td>
				</tr>
			</table>
		</div>
	</div>
	</main>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>

