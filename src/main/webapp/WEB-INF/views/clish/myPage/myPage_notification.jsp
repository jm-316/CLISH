<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 문의</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com" >
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Nanum+Myeongjo&family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Orelega+One&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" >
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<main id="container">
	
	<jsp:include page="/WEB-INF/views/clish/myPage/side.jsp"></jsp:include>
	
	<div id="main">
	
		<h1>${sessionScope.sId}의 페이지</h1>
		<hr>
		<h3>나의문의목록</h3>
<!-- 		<input type="hidden" id="parent" value="list"> -->
		<div>
			<h3>알림 전체</h3>
			<table border="1" style="width: 100%; border-collapse: collapse;">
				<thead style="background-color: #f5f5f5;">
	   			<tr>
	      			<th>알림 내용</th>
				    <th>알림 시간</th>

			    </tr>
			    </thead>
			  	<tbody>
				  	<c:forEach var="notification" items="${notificationList}">
					    <tr class="inquery-toggle">
					    	<td>${notification.userNoticeMessage}</td>
					      	<td>${notification.userNoticeCreatedAt }</td>
					    </tr>			
				  	</c:forEach>
			  	</tbody>
		  	</table>
			<section id="notificationList">
				<c:if test="${not empty notificationPageInfo.maxPage or notificationPageInfo.maxPage > 0}">
					<input type="button" value="이전" 
						onclick="location.href='/myPage/notification?notificationPageNum=${notificationPageInfo.pageNum - 1 }'" 
						<c:if test="${notificationPageInfo.pageNum eq 1}">disabled</c:if>
					>
					
					<c:forEach var="i" begin="${notificationPageInfo.startPage}" end="${notificationPageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq notificationPageInfo.pageNum}">
								<strong>${i}</strong>
							</c:when>
							<c:otherwise>
								<a href="/myPage/notification?notificationPageNum=${i}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<input type="button" value="다음" 
						onclick="location.href='/myPage/notification?notificationPageNum=${notificationPageInfo.pageNum + 1}'" 
						<c:if test="${notificationPageInfo.pageNum eq notificationPageInfo.maxPage}">disabled</c:if>
					>
				</c:if>
			</section>
		</div>
		
	
	</div>
	
	</main>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script>
	  $(document).ready(function () {
	    $(".inquery-toggle").click(function () {
	      const detailRow = $(this).next(".inquery-detail");
	
	      // 모든 detail 닫고, 클릭 대상이 닫혀있던 거면 열기
	      $(".inquery-detail").not(detailRow).slideUp(200);
	
	      if (!detailRow.is(":visible")) {
	        detailRow.slideDown();
	      } else {
	        detailRow.slideUp();
	      }
	    });
	  });
	</script>
</body>
</html>