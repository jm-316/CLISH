<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.event-detail-container {
	display: flex;
	flex-direction: column;
	margin-left: 30px;
}

.event-thumbnail, .event-content {
	display: flex;
	display: flex;
	flex-direction: column;
}

</style>
</head>
<body>
	<div class="container">
		<div class="sidebar">
			<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"></jsp:include>	
		</div>
		<div class="main">
			<jsp:include page="/WEB-INF/views/admin/header.jsp"></jsp:include>
			<div class="main_container">
				<div class="bg-light">
					<div>
						<div class="flex">
							<h5 class="section-title">이벤트상세보기</h5>
						</div>
					</div>
					<div class="event-detail-container">
						<div class="event-info">
						    <div>제목 : <span>${eventDTO.eventTitle}</span></div>
						    <div>날짜 : <span>${eventDTO.eventStartDate} ~ ${eventDTO.eventEndDate}</span></div>
						    <div>상태 : 
						    	<c:choose>
						    		<c:when test="${eventDTO.eventInProgress eq 0}">
						    			<span>종료</span>
						    		</c:when>
						    		<c:when test="${eventDTO.eventInProgress eq 1}">
						    			<span>진행중</span>
						    		</c:when>
						    		<c:otherwise>
								    	<span>예정</span>
						    		</c:otherwise>
						    	</c:choose>
						    </div>
					  	</div>
						<div class="event-thumbnail">
							<span>썸네일</span>
						    <img src="/file/${thumbnailFile.fileId}?type=2"  alt="이벤트 썸네일" width="500px;"/>
						</div>
						<div class="event-content">
						  <span>이벤트 본문</span>
						  <img src="/file/${contentFile.fileId}?type=0"  alt="이벤트 내용 이미지" width="500px;"/>
						</div>
					</div>
					<div class="button-wrapper">
						<button onclick="location.href='/admin/event/modify/${eventDTO.eventIdx}'">수정</button>
						<button onclick="deleteEvent('${eventDTO.eventIdx}')">삭제</button>
						<button onclick="location.href='/admin/event/?pageNum=${param.pageNum}'">목록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function deleteEvent(idx) {
			if (confirm("삭제하시겠습니까?")) {
				location.href="/admin/event/delete/" + idx;
			}
		}
	</script>
</body>
</html>