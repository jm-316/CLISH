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
  align-items: center;
  gap: 30px;
  padding: 20px;
}

.event-header {
  display: flex;
  justify-content: center;
  gap: 20px;
  width: 100%;
  flex-wrap: wrap;
}

.event-info {
  width: 400px;
  font-size: 1rem;
  line-height: 1.5;
}

.event-thumbnail {
  display: flex;
  flex-direction: column;
  width: 400px;
  align-items: center;
  gap: 8px;
}

.event-thumbnail img {
  max-width: 100%;
  height: auto;
  border-radius: 6px;
  box-shadow: 0 0 8px rgba(0,0,0,0.1);
}

.event-content {
  display: flex;
  flex-direction: column;
  width: 800px;
  max-width: 95%;
  gap: 8px;
}

.event-content img {
  width: 100%;
  height: auto;
  border-radius: 5px;
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
						<div class="event-header">
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
						    <img src="/resources/upload/${thumbnailFile.subDir}/${thumbnailFile.realFileName}" alt="이벤트 썸네일" />
						  </div>
						</div>
						<div class="event-content">
						  <span>이벤트 본문</span>
						  <img src="/resources/upload/${contentFile.subDir}/${contentFile.realFileName}" alt="이벤트 내용 이미지" />
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