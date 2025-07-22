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
			<div class="navbar-expand">
				<h4 class="pageSubject">CLISH 관리자 대시보드</h4>
				<div>관리자</div>
			</div>
			<div class="main_container">
				<div class="bg-light">
					<div>
						<div class="flex">
							<h5 class="section-title">FAQ</h5>
							<button onclick="location.href='/admin/faq/writeFaq'" class="submitBtn">등록</button>
						</div>
						<form class="filter-form">
							<select class="filter-select">
								<option>전체</option>
								<option>강의수강</option>
								<option>계정관리</option>
								<option>결제환불</option>
							</select>
							<div class="search-box">
								<input type="text" class="search-input" placeholder="내용을 검색해주세요."/>
								<button class="search-button">검색</button>
							</div>
						</form>
					</div>
					<div>
						<div>
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
									<c:forEach var="faq" items="${faqList}" varStatus="status" >
										<tr>
											<td>${status.index + 1}</td>
											<td>${faq.supportTitle}</td>
											<td>${faq.supportCreatedAt}</td>
											<td>${faq.supportCategory}</td>
											<td class="flex">
												<button onclick="location.href='/admin/faq/detail/${faq.supportIdx}'">상세보기</button>
												<button onclick="location.href='/admin/faq/delete/${faq.supportIdx}'">삭제</button>
											</td>
										</tr>
									</c:forEach>									
								</tbody>
							</table>
						
						</div>
					
					</div>
				
				</div>
			</div>
		</div>
	</div>
</body>
</html>