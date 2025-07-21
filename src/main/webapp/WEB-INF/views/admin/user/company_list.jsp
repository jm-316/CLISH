<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
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
						<div>
							<h5 class="section-title">기업 회원 목록</h5>
						</div>
						<form class="filter-form">
							<select class="filter-select">
								<option>전체</option>
								<option>최신가입순</option>
								<option>오래된가입순</option>
								<option>승인대기</option>
								<option>승인완료</option>
							</select> 
							<div class="search-box">
								<input type="text" class="search-input"/>
								<button class="search-button">검색</button>
							</div>
						</form>
					</div>
					<div>
						<table class="table">
							<thead>
								<tr>
									<th>회원번호</th>
									<th>회원아이디</th>
									<th>이름</th>
									<th>연락처</th>
									<th>이메일</th>
									<th>가입일</th>
									<th>상태</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="company" items="${companys}">
									<tr>
										<td>${company.userIdx}</td>
										<td>${company.userId}</td>
										<td>${company.userName}</td>
										<td>${company.userPhoneNumber}</td>
										<td>${company.userEmail}</td>
										<td>${company.userRegDate}</td>
										<td>
											<c:choose>
												<c:when test="${company.userStatus == 1}">
										            승인
										        </c:when>
												<c:otherwise>
										            대기
										        </c:otherwise>
											</c:choose>
										</td>
										<td>
											<button onclick="location.href='/admin/company/${company.userIdx}'" >
												수정
											</button>
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
</body>
</html>