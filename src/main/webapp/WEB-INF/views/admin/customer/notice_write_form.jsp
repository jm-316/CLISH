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
							<h5 class="section-title">공지사항 작성</h5>
						</div>
					</div>
					<div>
						<form action="/admin/notice/writeNotice" method="post">
							<table>
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
								<tbody>
									<tr>
										<th>작성자</th>
										<td><input type="text" value="운영자" disabled/></td>
									</tr>
									<tr>
										<th>제목</th>
										<td><input type="text" name="supportTitle" id="supportTitle"/></td>
									</tr>
									<tr>
										<th>내용</th>
										<td><textarea rows="10" cols="10" name="supportDetail" id="supportDetail"></textarea></td>
									</tr>
									<tr>
										<th>파일첨부</th>
										<td><input type="file" name="supportAttach"/></td>
									</tr>
								</tbody>
							</table>
							<div class="button-wrapper">
								<button type="submit" >등록</button>
								<button type="button" onclick="history.back()">취소</button>
							</div>
						</form>
					</div>
				
				</div>
			</div>
		</div>
	</div>
</body>
</html>