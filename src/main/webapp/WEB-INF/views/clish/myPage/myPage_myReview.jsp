<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강 후기 관리</title>
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
		<input type="button" class="reviewbar" value="작성 가능 수강후기"
		onclick="location.href='/myPage/myReview?reviewCom=0'">
		<input type="button" class="reviewbar" value="작성 한 수강후기"
		onclick="location.href='/myPage/myReview?reviewCom=1'">
		</div>
		<div>
		<h1>${param.reviewCom }</h1>
			<table>
				<c:forEach items="${reviewInfo}" var="review">
					<tr>
						<th rowspan="2">이미지</th>
						<th>수강 강의</th>
						<th>수강일</th>
						<c:choose>
							<c:when test="${param.reviewCom eq 0 }" >
								<td rowspan="2">
									<input type="button" value="강의 상세 페이지" 
									onclick="location.href='/course/user/classDetail?classIdx=${review.class_idx}&classType=${review.class_type }&categoryIdx=${review.category_idx }'">
									
									<br><br>
									<!-- classIdx=CLC20250712154900&classType=0&categoryIdx=CT_it_backend -->
									<input type="button" value="수강후기쓰러가기"
									onclick="location.href='/myPage/myReview/writeReviewForm?reservationIdx=${review.reservation_idx}'">
								</td>
							</c:when>
							<c:otherwise>
								<td rowspan="2">
									<input type="button" value="작성 후기 보러 가기" 
									onclick="location.href='/course/user/classDetail?classIdx=${review.class_idx}&classType=${review.class_type }&categoryIdx=${review.category_idx }'">
									
									<br><br>
									<!-- classIdx=CLC20250712154900&classType=0&categoryIdx=CT_it_backend -->
									<input type="button" value="작성 후기 수정"
									onclick="location.href='/myPage/myReview/writeReviewForm?reservationIdx=${review.reservation_idx}'">
								</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<td>${review.class_title }</td>
						<td>${review.reservation_class_date }</td>
					</tr>
				</c:forEach>
			</table>
			<section id="reviewPageList">
				<c:if test="${not empty pageInfo.maxPage or pageInfo.maxPage > 0}">
					<input type="button" value="이전" 
						onclick="location.href='/myPage/myReview?reviewPageNum=${pageInfo.pageNum - 1}'" 
						<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
					>
					
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq pageInfo.pageNum}">
								<strong>${i}</strong>
							</c:when>
							<c:otherwise>
								<a href="/myPage/myReview?reviewPageNum=${i}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<input type="button" value="다음" 
						onclick="location.href='/myPage/myReview?reviewPageNum=${pageInfo.pageNum + 1}'" 
						<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>
					>
				</c:if>
			</section>
		</div>
	</div>
	</main>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>

