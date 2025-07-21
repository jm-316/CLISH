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
						<div>
							<h5 class="section-title">공지사항</h5>
						</div>
						<c:forEach var="support" items="${supportList}">
							${support }
						</c:forEach>
					</div>
				
				</div>
			</div>
		</div>
	</div>
</body>
</html>