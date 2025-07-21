<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 수정 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/admin/header.jsp"></jsp:include>
	</header>
	<main>
		<section style="max-width: 800px; margin: 50px auto; padding: 40px;">
		
			<h1>클래스 수정 페이지</h1>
			<h3 style="text-align: center; margin-bottom: 30px;">[ 클래스 수정 ]</h3>

			<form action="/company/myPage/modifyClass" method="post">
				<!-- classIdx는 숨겨서 전달 -->
				<input type="hidden" name="classIdx" value="${classInfo.classIdx}" />

				<table class="table-with-side-borders" style="width: 90%;">
					<tr>
						<th>계정</th>
						<td><input type="text" name="userIdx" value="${classInfo.userIdx}"></td>
					</tr>
					<tr>
						<th>강의명</th>
						<td><input type="text" name="classTitle" value="${classInfo.classTitle}"></td>
					</tr>
					<tr>
						<th>카테고리 ID</th>
						<td><input type="text" name="categoryIdx" value="${classInfo.categoryIdx}"></td>
					</tr>
					<tr>
						<th>수강료</th>
						<td><input type="number" name="classPrice" value="${classInfo.classPrice}"></td>
					</tr>
					<tr>
						<th>정원</th>
						<td><input type="number" name="classMember" value="${classInfo.classMember}"></td>
					</tr>
					<tr>
						<th>강의 기간</th>
						<td>
							<input type="date" name="startDate" value="${classInfo.startDate}">
							~
							<input type="date" name="endDate" value="${classInfo.endDate}">
						</td>
					</tr>
					<tr>
						<th>수업요일</th>
						<td><input type="text" name="classDayNames" value="${classInfo.classDayNames}"></td>
					</tr>
					<tr>
						<th>장소</th>
						<td><input type="text" name="location" value="${classInfo.location}"></td>
					</tr>
					<tr>
						<th>강의 소개</th>
						<td><textarea name="classIntro">${classInfo.classIntro}</textarea></td>
					</tr>
					<tr>
						<th>강의 상세 내용</th>
						<td><textarea name="classContent">${classInfo.classContent}</textarea></td>
					</tr>
					<tr>
						<th>썸네일 이미지 경로</th>
						<td><input type="text" name="classPic1" value="${classInfo.classPic1}"></td>
					</tr>
				</table>

				<h3>📚 커리큘럼 소개</h3>
				<!-- 커리큘럼 수정 가능하게 input으로 변경 -->
				<c:forEach var="curri" items="${curriculumList}">
					<div style="margin-bottom: 10px;">
						<input type="text" name="curriculumTitle" value="${curri.curriculumTitle}" placeholder="제목">
						<input type="text" name="curriculumRuntime" value="${curri.curriculumRuntime}" placeholder="시간">
					</div>
				</c:forEach>

				<div style="display: flex; justify-content: center; margin-top: 40px;">
				    <button type="submit" class="orange-button">
				        수정 완료
				    </button>
				</div>
			</form>
		</section>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/admin/bottom.jsp"></jsp:include>
	</footer>

</body>
</html>