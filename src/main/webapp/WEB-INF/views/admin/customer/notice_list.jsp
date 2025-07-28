<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${not empty msg}">
		<script>
	    	alert("${msg}");
	    </script>
	</c:if>
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
							<h5 class="section-title">공지사항</h5>
							<button onclick="location.href='/admin/notice/writeNotice'" class="submitBtn">등록</button>
						</div>
						<form class="filter-form">
							<select class="filter-select">
								<option>최신순</option>
								<option>과거순</option>
							</select>
							<div class="search-box">
								<input type="text" class="search-input"/>
								<button class="search-button">검색</button>
							</div>
						</form>
					</div>
					<div>
						<div style="height: 250px;">
							<table>
								<thead>
									<tr>
										<th>게시판번호</th>
										<th>제목</th>
										<th>작성일자</th>
										<th>게시판유형</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="support" items="${supportList}" varStatus="status" >
										<tr>
											<td>${pageInfo.startRow + status.index + 1}</td>
											<td>${support.supportTitle}</td>
											<td>${support.supportCreatedAt}</td>
											<td>${support.supportCategory}</td>
											<td class="flex">
												<button onclick="location.href='/admin/notice/detail/${support.supportIdx}?pageNum=${param.pageNum}'">상세보기</button>
												<button onclick="location.href='/admin/notice/delete/${support.supportIdx}'">삭제</button>
											</td>
										</tr>
									</c:forEach>									
								</tbody>
							</table>
						</div>
						<div style="display: flex; align-items: center; justify-content: center; margin-top: 50px;">
							<div>
								<c:if test="${not empty pageInfo.maxPage or pageInfo.maxPage > 0}">
									<input type="button" value="이전" onclick="location.href='/admin/notice?pageNum=${pageInfo.pageNum - 1}'" 
								<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>>
								<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
									<c:choose>
										<c:when test="${i eq pageInfo.pageNum}">
											<strong>${i}</strong>
										</c:when>
										<c:otherwise>
											<a href="/admin/notice?pageNum=${i}">${i}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<input type="button" value="다음" onclick="location.href='/admin/notice?pageNum=${pageInfo.pageNum + 1}'" 
										<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>