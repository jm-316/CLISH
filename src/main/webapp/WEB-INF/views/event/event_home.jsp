<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Clish - 이벤트</title>
<link rel="preconnect" href="https://fonts.googleapis.com" >
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="/resources/css/home/top.css" rel="stylesheet" >
<link rel="stylesheet" href="/resources/css/the_best_styles.css" >
<!-- 강의 사이드바 css 활용 -->
<link rel="stylesheet" href="/resources/css/course/sidebar.css">
<style type="text/css">
	.event-table {
	width: 1200px;
	margin: 200px auto;
	
	}
	main.main {
	padding: none;
	}
</style>
<script type="text/javascript" src="/resources/js/home.js"></script>
<link rel='icon' href='/resources/images/logo4-2.png' type='image/x-icon'/>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include> 
	</header>
		<jsp:include page="/WEB-INF/views/event/sidebar.jsp" />
	<main class="main">
	<div class="main">
		<div class="main-content">
			
			<table class="table event-table">
				<thead>
					<tr>
						<th colspan="6"><h2>현재 가의 이벤트</h2></th>
					</tr>
					<tr>
						<th>썸네일</th>
						<th>제목</th>
						<th rowspan="2">이벤트 설명</th>
						<th>일자</th>
						<th>진행 상태</th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="event" items="${eventList}">
							<tr onclick="#">
								<td >
									<img src="/resources/images/logo4-2.png" alt="썸네일" style="width: 100px; height: auto;">
								</td>
								<td onclick="location.href='/course/user/classDetail?classIdx=${classItem.classIdx}&classType=${classItem.classType}&categoryIdx=${classItem.categoryIdx}'">
									${event.eventTitle}
								</td>
								<td>${event.eventDescription}</td>
								<td>${event.eventStartDate} ~ ${event.eventEndDate}</td>
								<td>
									<c:choose>
										<c:when test="${event.eventInProgress == 1}">
											진행중  
										</c:when>
										<c:otherwise>
											예정 
										</c:otherwise>
									</c:choose>
								</td>
		
							</tr>
					</c:forEach>
					
				</tbody>
			</table>
		</div>
	</div>
	
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>