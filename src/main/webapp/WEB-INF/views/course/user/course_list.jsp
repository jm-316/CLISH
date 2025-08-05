<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/top.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/course/sidebar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/course/course_list.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script>
	// 카테고리 셀렉트 박스가 바뀌었을 때 함수 실행
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
	
	<jsp:include page="/WEB-INF/views/course/sidebar.jsp" />
		
		<div class="main">
			<div class="main-content">
				<div class="box">
				<div id="search-container">
					<%-- 카테고리별 검색 셀렉트박스 --%>
					<select id="categorySelect" onchange="filterByCategory()">
						<option value="">카테고리 선택</option>
						<c:forEach var="parentCat" items="${parentCategories}">
							<option value="${parentCat.categoryIdx}">
								${fn:substringAfter(parentCat.categoryIdx, 'CT_')}
							</option>
						</c:forEach>
					</select>
				<%-- 검색 기능을 위한 폼 생성 --%>
					<form action="/course/user/classList" method="get">
						<%-- 파라미터에 검색어(searchKeyword) 있을 경우 해당 내용 표시 --%>
						<input type="hidden" name="classType" value="${param.classType}">
						<input type="text" name="searchClassKeyword" value="${param.searchClassKeyword}" placeholder="검색어를 입력하세요."/>
						<input type="submit" value="검색" />
					</form>
				</div>
					
					
					<%-- 기업 유저의 경우 클래스 개설 버튼 표시 --%>
					<c:if test="${userInfo.userType eq 2}">
		                <button class="orange-button"
		                        onclick="location.href='${pageContext.request.contextPath}/company/myPage/registerClass'">
		                    클래스 개설
		                </button>
	                </c:if>
				</div>
				
				
				<%-- 클래스 목록 리스트 --%>
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
						<c:set var="hasRegisteredClass" value="false" /> <%-- 클래스 목록 확인용 변수(boolean) --%> 
						<%-- 클래스 목록이 있을 경우 --%>
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
											<%-- 신청가능 클래스이면서 일반 유저일 경우 예약 버튼 활성화 --%>
											<c:when test="${classItem.classStatus == 2 and userInfo.userType eq 1}">
												오픈 <button onclick="location.href='/course/user/classReservation?&classType=${classItem.classType}&classIdx=${classItem.classIdx}'">예약</button>
											</c:when>
											<%-- 관리자일 경우 관리자 아이디라는 것을 표시 --%>
											<c:when test="${userInfo.userType eq 3}">
												관리자
											</c:when>
											<%-- 신청이 마감된 클래스는 예약 버튼 비활성화 및 마감 표시 --%>
											<c:otherwise>
												마감 <button disabled>예약</button>
											</c:otherwise>
										</c:choose>
									</td>
									<%-- 기업 유저의 경우 수정버튼 표시 --%>
									<c:if test="${userInfo.userType eq 2}">
										<td>
											<button onclick="location.href='/company/myPage/modifyClass?classIdx=${classItem.classIdx}'">수정</button>
										</td>
									</c:if>
								</tr>
							</c:if>
						</c:forEach>
						<%-- 클래스 목록이 없을 경우 --%>
						<c:if test="${not hasRegisteredClass}">
							<tr>
								<td colspan="6">등록된 강의가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				
				<%-- 페이지 리스트 --%>
				<section id="pageList">
					<c:if test="${not empty param.searchClassKeyword}">
						<c:set var="searchParams" value="classType=${param.classType}&searchClassKeyword=${param.searchClassKeyword}" />
					</c:if>
					
					<c:if test="${not empty pageInfoDTO.maxPage or pageInfoDTO.maxPage > 0}">
						<input type="button" value="이전" 
							onclick="location.href='/course/user/classList?pageNum=${pageInfoDTO.pageNum - 1}&${searchParams}'" 
							<c:if test="${pageInfoDTO.pageNum eq 1}">disabled</c:if>
						>
						
						<c:forEach var="i" begin="${pageInfoDTO.startPage}" end="${pageInfoDTO.endPage}">
							<c:choose>
								<c:when test="${i eq pageInfoDTO.pageNum}">
									<strong>${i}</strong>
								</c:when>
								<c:otherwise>
									<a href="/course/user/classList?pageNum=${i}&${searchParams}">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<input type="button" value="다음" 
							onclick="location.href='/course/user/classList?pageNum=${pageInfoDTO.pageNum + 1}&${searchParams}'" 
							<c:if test="${pageInfoDTO.pageNum eq pageInfoDTO.maxPage}">disabled</c:if>
						>
					</c:if>
				</section>
			</div>
		</div>
		
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include> 
	</footer>
</body>
</html>
