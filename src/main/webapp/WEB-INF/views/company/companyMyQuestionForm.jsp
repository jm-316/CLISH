<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>사이트 문의 작성</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
  <style>
    .form-wrapper {
      max-width: 800px;
      margin: 30px auto;
      padding: 20px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      padding: 10px;
      vertical-align: top;
      border-bottom: 1px solid #ddd;
    }
    th {
      width: 120px;
      text-align: left;
      background-color: #f4f4f4;
    }
    textarea {
      width: 100%;
      height: 150px;
    }
    .btn-wrap {
      text-align: center;
      margin-top: 30px;
    }
    .btn-wrap button {
      padding: 10px 20px;
      margin: 0 10px;
    }
  </style>
</head>
<body>
  	<div class="form-wrapper">
	    <h2>사이트 문의 <c:out value="${empty inqueryDTO ? '작성' : '수정'}"/></h2>
	
	    <!-- ✅ form action JSTL로 분기해서 변수에 저장 -->
	    <c:choose>
			<c:when test="${empty inqueryDTO}">
				<c:set var="formAction" value="/company/myPage/writeInquery"/>
			</c:when>
		<c:otherwise>
			<c:set var="formAction" value="/company/myPage/modifyInquery"/>
		</c:otherwise>
		</c:choose>

	    <!-- ✅ 하나의 form 태그 -->
	    <form action="${pageContext.request.contextPath}${formAction}" method="post" enctype="multipart/form-data">
			<!-- 고정 값 -->
			<input type="hidden" name="inqueryType" value="2" />
			<input type="hidden" name="userIdx" value="${sessionScope.userIdx}" />

		<c:if test="${not empty inqueryDTO.inqueryIdx}">
			<input type="hidden" name="inqueryIdx" value="${inqueryDTO.inqueryIdx}" />
		</c:if>

		<table>
	        <tr>
				<th>제목</th>
				<td>
					<input type="text" name="inqueryTitle" value="${inqueryDTO.inqueryTitle}" required />
				</td>
	        </tr>
	        <tr>
				<th>내용</th>
				<td>
					<textarea name="inqueryDetail" required>${inqueryDTO.inqueryDetail}</textarea>
				</td>
	        </tr>
	        <tr>
				<th>첨부파일</th>
				<td>
					<input type="file" name="files" multiple />
				</td>
	        </tr>
		</table>

		<div class="btn-wrap">
			<button type="submit"><c:out value="${empty inqueryDTO ? '등록' : '수정'}"/></button>
			<button type="button" onclick="history.back()">취소</button>
		</div>
		</form>
	</div>
</body>
</html>
