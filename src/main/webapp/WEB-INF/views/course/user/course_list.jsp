<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/top.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/course/sidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/course/course_list.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script>
	function filterByCategory() {
		const selected = document.getElementById('categorySelect').value;
		location.href = '/course/user/classList?classType=${param.classType}&categoryIdx=' + selected;
	}
</script>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<div class="layout-container">
		<jsp:include page="/WEB-INF/views/course/sidebar.jsp" />
		<div class="main">
			<div class="main-content">
				<div class="box">
					<select id="categorySelect" onchange="filterByCategory()">
						<option value="">카테고리 선택</option>
						<c:forEach var="parentCat" items="${parentCategories}">
							<option value="${parentCat.categoryIdx}">
								${fn:substringAfter(parentCat.categoryIdx, 'CT_')}
							</option>
						</c:forEach>
					</select>
					<select>
						<option value="이전등록순">이전등록순</option>
						<option value="최신등록순">최신등록순</option>
					</select>
				</div>
				<table class="table">
					<thead>
						<tr>
							<th colspan="6">강좌 목록</th>
						</tr>
						<tr>
							<th>썸네일</th>
							<th>제목</th>
							<th>일자</th>
							<th>장소</th>
							<th colspan="2">진행상태</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="hasRegisteredClass" value="false" />
						<c:forEach var="classItem" items="${classList}">
							<c:if test="${classItem.classStatus != 1}">
								<c:set var="hasRegisteredClass" value="true" />
								<tr>
									<td onclick="location.href='/course/user/classDetail?classIdx=${classItem.classIdx}&classType=${classItem.classType}&categoryIdx=${classItem.categoryIdx}'">
										<img src="/resources/images/logo4-2.png" alt="썸네일" style="width: 100px; height: auto;">
									</td>
									<td onclick="location.href='/course/user/classDetail?classIdx=${classItem.classIdx}&classType=${classItem.classType}&categoryIdx=${classItem.categoryIdx}'">
										${classItem.classTitle}
									</td>
									<td>${classItem.startDate} ~ ${classItem.endDate}</td>
									<td>${classItem.location}</td>
									<td>
										<c:choose>
											<c:when test="${classItem.classStatus == 2 and user.userType eq 1}">
												오픈 <button onclick="location.href='/course/user/courseReservation?classIdx=${classItem.classIdx}'">예약</button>
											</c:when>
											<c:when test="${user.userType eq 3}">
												관리자
											</c:when>
											<c:otherwise>
												마감 <button disabled>예약</button>
											</c:otherwise>
										</c:choose>
									</td>
									<c:if test="${user.userType eq 2}">
										<td>
											<button onclick="location.href='/company/myPage/modifyClass?classIdx=${classItem.classIdx}'">수정</button>
										</td>
									</c:if>
								</tr>
							</c:if>
						</c:forEach>
						<c:if test="${not hasRegisteredClass}">
							<tr>
								<td colspan="6">등록된 강의가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/admin/bottom.jsp" />
</body>
</html>
