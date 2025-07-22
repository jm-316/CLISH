<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/course/sidebar.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<!-- 	 클래스 썸네일 클릭 시 클래스 상세정보 이동 -->
	<!-- 	- 클래스 제목, 강사명, 일자, 장소, 사진 노출 -->
	<!-- 	- 기업회원의 경우 강의 등록 버튼 생성 -->
	<div class="page-container">
		<main class="main">
			<div class="main-content">
				<div align="center">
					<div class="box" align="right">
						<select onchange="">
								<option value="카테고리 선택" selected>카테고리 선택</option>
							<c:forEach var="parentCat" items="${parentCategories}">
								<option value="${fn:substringAfter(parentCat.categoryIdx, 'CT_')}">${fn:substringAfter(parentCat.categoryIdx, 'CT_')}</option>
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
								<th>진행상태</th>
								<th colspan="1"></th>
							</tr>
						</thead>
						<tbody>
							<c:set var="hasRegisteredClass" value="false" />
							<c:forEach var="classItem" items="${classList}">
								<c:if test="${classItem.classStatus != 1}">
									<c:set var="hasRegisteredClass" value="true" />
									<tr>
										<td
											onclick="location.href='/course/user/classDetail?classIdx=${classItem.classIdx}&classType=${classItem.classType}&categoryIdx=${classItem.categoryIdx}'">
											<img src="/resources/images/logo4-2.png" alt="썸네일" style="width: 100px; height: auto;">
<%-- 											<img src="/resources/images/${classItem.classPic1}" alt="썸네일" style="width: 100px; height: auto;"> --%>
										</td>
										<td
											onclick="location.href='/course/user/classDetail?classIdx=${classItem.classIdx}&classType=${classItem.classType}&categoryIdx=${classItem.categoryIdx}'">
											${classItem.classTitle}</td>
										<td>${classItem.startDate} ~ ${classItem.endDate}</td>
										<td>${classItem.location}</td>
										<td><c:choose>
												<c:when test="${classItem.classStatus == 2}">오픈</c:when>
												<c:otherwise>마감</c:otherwise>
											</c:choose></td>
										<c:if test="${user.userType eq 1}">
											<td><button
													onclick="location.href='/course/user/courseReservation?classIdx=${classItem.classIdx}'">예약</button></td>
										</c:if>
										<c:if test="${user.userType eq 2}">
											<td><button
													onclick="location.href='/company/myPage/modifyClass?classIdx=${classItem.classIdx}'">수정</button></td>
										</c:if>
									</tr>
								</c:if>
							</c:forEach>
							<c:if test="${not hasRegisteredClass}">
								<tr>
									<td colspan="5">등록된 강의가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			<div class="sidebar">
				<ul class="category-list">
					<c:choose>
						<c:when test="${param.classType eq 0}">
							<c:set var="classType" value="정기 강의" />
						</c:when>
						<c:otherwise>
							<c:set var="classType" value="단기 강의" />
						</c:otherwise>
					</c:choose>
					<c:if test="${param.classType eq 0 or param.classType eq 1}">
						<li><a href="/course/user/classList?classType=${param.classType}"><strong>${classType}</strong></a></li>
						<c:forEach var="Pcat" items="${parentCategories}">
							<li><a
								href="/course/user/classList?classType=${param.classType}&categoryIdx=${Pcat.categoryIdx}">
									${Pcat.categoryName}</a></li>
							<c:forEach var="Ccat" items="${childCategories}">
								<c:if test="${Ccat.parentIdx eq Pcat.categoryIdx}">
									<li><a
										href="/course/user/classList?classType=${param.classType}&categoryIdx=${Ccat.categoryIdx}">
											${Ccat.categoryName}</a></li>
								</c:if>
							</c:forEach>
						</c:forEach>
					</c:if>
				</ul>
			</div>
		</main>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/admin/bottom.jsp" />
	</footer>

</body>
</html>