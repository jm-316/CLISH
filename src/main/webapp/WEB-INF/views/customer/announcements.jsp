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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/main.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/course/sidebar.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<style type="text/css">
.search-container {
  display: flex;
  justify-content: flex-end; 
  gap: 0.3rem;               
}

.search-container form {
  display: flex !important;  
  align-items: center;
  padding: 0 !important;
  margin: 0 !important;
  border: none !important;
  width: auto !important;   
}

.search-container select,
.search-container input,
.search-container button {
  height: 34px;
  font-size: 0.875rem;
  border-radius: 4px;
  margin: 0;
}

.search-form {
  display: flex !important;
  justify-content: flex-end;
  align-items: center;
  gap: 0.3rem;
  border: none !important;
  padding: 0 !important;
  margin: 0 !important;
  width: auto !important;           
}

.search-form select,
.search-form input[type="text"],
.search-form button {
  height: 34px !important;           
  font-size: 0.875rem;
  border-radius: 4px;
  margin: 0 !important;              
  box-sizing: border-box;
}

.search-form select,
.search-form input[type="text"] {
  width: auto !important;            
  padding: 0 0.5rem;
  line-height: 1.2;                 
  border: 1px solid #d9d9d9;
}

.search-form button {
  width: auto !important;            
  padding: 0 10px;
  display: inline-flex;              
  align-items: center;
  justify-content: center;
  background-color: #FF8C00;
  color: #fff;
  border: 1px solid transparent;     
}

</style>
</head>
<body>
	<c:if test="${not empty msg}">
		<script>
	    	alert("${msg}");
	    </script>
	</c:if>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include> 
	</header>
	<nav>
		<jsp:include page="/WEB-INF/views/customer/sidebar.jsp" />
	</nav>
	<div style="display: flex;">
		<div ></div>
		<div style="width: calc(100vw - 440px); height: 500px; margin-left: 220px">
			<h3 style="font-size: 1.8rem; text-align: left; margin-top: 30px;">공지사항</h3>
			<div class="search-container" style="margin-top: 30px; margin-bottom: 30px;">
			    <form class="search-form">
			        <select>
			            <option>최신순</option>
			            <option>오래된순</option>
			        </select>
			    </form>
			    <form class="search-form">
			        <select>
			            <option>제목</option>
			            <option>내용</option>
			            <option>제목&내용</option>
			        </select>
			        <input type="text" placeholder="검색어를 입력하세요"/>
			        <button>검색</button>
			    </form>
			</div>
			<div style="height: 250px;">
				<table style="width: 100%; margin: 0">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="announcement" items="${announcementList}" varStatus="status" >
							<tr>
								<td style="text-align: center;"> ${pageInfo.startRow + status.index + 1}</td>
								<td onclick="location.href='/customer/announcement/detail/${announcement.supportIdx}'" style="text-align: left; width: 60%">${announcement.supportTitle}</td>
								<td style="text-align: center;">관리자</td>
								<td style="text-align: center;">${announcement.supportCreatedAt}</td>
							</tr>
						</c:forEach>		
					</tbody>
				</table>
			</div>
			<div style="display: flex; align-items: center; justify-content: center; margin-top: 30px;">
				<div>
					<c:if test="${not empty pageInfo.maxPage or pageInfo.maxPage > 0}">
						<input type="button" value="이전" 
							onclick="location.href='/customer/announcements?pageNum=${pageInfo.pageNum - 1}'" 
							<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
						>
						
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<c:choose>
								<c:when test="${i eq pageInfo.pageNum}">
									<strong>${i}</strong>
								</c:when>
								<c:otherwise>
									<a href="/customer/announcements?pageNum=${i}">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<input type="button" value="다음" 
							onclick="location.href='/customer/announcements?pageNum=${pageInfo.pageNum + 1}'" 
							<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
						</c:if>
					</div>
				</div>
			<c:if test="${userType == 3}">			
				<div style="display: flex; justify-content: flex-end;">
					<button onclick="location.href='/customer/announcements/write'">글쓰기</button>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>	