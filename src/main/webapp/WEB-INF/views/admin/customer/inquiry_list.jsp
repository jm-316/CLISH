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
							<h5 class="section-title">문의관리</h5>
						</div>
<!-- 						<form class="filter-form"> -->
<!-- 							<select class="filter-select"> -->
<!-- 								<option>전체</option> -->
<!-- 								<option>1:1문의</option> -->
<!-- 								<option>강의 문의</option> -->
<!-- 							</select> -->
<!-- 						</form> -->
					<div class="sort-buttons">
						<button class="sort-button" data-value="all">전체</button>
					    <button class="sort-button" data-value="personal">1:1문의</button>
					    <button class="sort-button" data-value="course">강의문의</button>
					</div>
					</div>
					<div>
						<div>
							<table>
								<thead>
									<tr>
										<th>게시판번호</th>
										<th>문의유형</th>
										<th>제목</th>
										<th>작성자</th>
										<th>등록일</th>
										<th>상태</th>
										<th>답변여부</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="inquiry" items="${inquiryList}" varStatus="status" >
										<tr>
											<td>${status.index + 1}</td>
											<td>${inquiry.inquery_type}</td>
											<td>${inquiry.inquery_title}</td>
											<td>${inquiry.user_name}</td>
											<td>${inquiry.inquery_datetime}</td>
											<td>${inquiry.inquery_status}</td>
											<td>${inquiry.inquery_status}</td>
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