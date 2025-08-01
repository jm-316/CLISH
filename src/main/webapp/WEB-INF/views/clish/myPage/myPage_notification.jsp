<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 알림</title>
<style type="text/css">
.notiTr {
	cursor: pointer;
}
</style>
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
					    <tr class="notiTr">
					    	<td>
					    		<input type="hidden" class="notiIdx" value="${notification.noticeIdx }">
					    		<a href="${notification.userNoticeLink }">
						    		${notification.userNoticeMessage}
					    		</a>
					    		<c:choose>
					    			<c:when test="${notification.userNoticeReadStatus eq 2 }">
					    				<!-- 0일때 안읽음 -->
					    				<span class="circle unread"></span>
					    			</c:when>
					    			<c:otherwise>
					    				<!--  1일때 읽음 표시 -->
					    				<span class="circle read"></span>
					    			</c:otherwise>
					    		</c:choose>
					    	</td>
					      	<td>
					      		${notification.userNoticeCreatedAt }
					      	</td>
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
	<script type="text/javascript">
		$(document).ready(function() {
			$('.notiTr').on('click', function(e) {
				var $this = $(this);
				//a 태그의 href 속성을 읽어와서 페이지 이동
				var link = $(this).find('a').attr('href'); // 🔴
// 				window.location.href = link;               // 🔴
	
			    //input(hidden)에서 idx 값 읽어오기
			    var idx = $(this).find('.notiIdx').val();  // 🔴
				console.log("idx : " + idx);
			    //읽음 처리 함수 호출, 성공시 읽음상태표시 변경
			    markAsRead(idx).then(response =>{
			    	if(response.ok){
			    		$this.find('span.circle.unread').removeClass('unread').addClass('read');
			    	} else {
			    		console.error('읽음 처리 실패 : 서버 응답 실패');
			    	}
			    }).catch(error => {
			    	alert("잠시후 다시 시도해 주세요");
			    });
			    
			});
	
			 // 알림 읽음 처리함수
			function markAsRead(noticeIdx) {
				return fetch("/user/notification/" + noticeIdx + "/read", {
    				method : "POST"
    			});
   			}
		});
	</script>
</body>
</html>