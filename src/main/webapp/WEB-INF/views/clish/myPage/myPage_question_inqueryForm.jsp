<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의수정</title>
<link href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/myPage.css" rel="stylesheet" type="text/css">

</head>
<body>
	<main id="container">
	
	<div id="main">
	
		<h1>문의수정</h1>
		<form action="/myPage/myQuestion/inquery/modify" method="post">
		<input type="hidden" name="inqueryIdx" value="${inqueryDTO.inqueryIdx }">
		<table >
			<tr>
				<th>이름</th>
				<td>${user.userName }</td>
				<th>문의시각</th>
				<td>${inqueryDTO.inqueryDatetime }</td>
			</tr>
			<c:if test="${!empty inqueryDTO.classTitle }">
				<tr>
					<th>강의명</th>
					<td colspan="3"> <input type="text" value="${inqueryDTO.classTitle }"></td>
				</tr>
			</c:if>
        	<tr>
        		<th>제목</th>
        		<td colspan="3"> <input type="text" name="inqueryTitle" value="${inqueryDTO.inqueryTitle }"></td>
        	</tr>
        	<tr>
				<th colspan="4">문의내용</th>
			</tr>
        	<tr>
        	<td colspan="4"><textarea rows="20" cols="50" name="inqueryDetail">${inqueryDTO.inqueryDetail }</textarea></td>
        	
        	<tr>
				<td colspan="6">
					<input type="button" value="취소" onclick="history.back()">
					<input type="submit" value="수정완료" >
         		</td>        		
        	</tr>
		</table>
		</form>
		
	
	</div>
	
	</main>
	

</body>
</html>