<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<jsp:include page="/WEB-INF/views/course/sidebar.jsp" />
	
	<div class="main">
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
		
		<section class="breadcrumb">
            <a href="#">카테고리</a> <i class="fa-solid fa-angle-right"></i>
            <a href="Category?codetype=CATE01">IT/개발</a> <i class="fa-solid fa-angle-right"></i>
            <a href="Category?codetype=CATE01&codetype_id=03">
            	<span>백엔드</span>
            </a>
        </section>
        
		<section class="class-details">
			<div class="class-container">
	        	<div class="cls-pic">
	  				<img src="/resources/images/logo4-2.png" id="preview" class="figure-img img-fluid rounded" alt="thumpnail" style="height: 280px;">
	            </div>
	
				<div class="cls-info-card">
					<h2 class="class-title">${classInfo.classTitle}</h2>
					<p class="class-description">${classInfo.classIntro}</p>
					<div class="class-tags">
						<c:forEach var="childCat" items="${childCategories}">
							<c:if test="${childCat.categoryIdx eq classInfo.categoryIdx }">
								<span class="tag">#${childCat.categoryName}</span>
							</c:if>
						</c:forEach>
					</div>
					<div class="class-meta">
						<span class="stars"><i class="fa-solid fa-star"></i> 2.0</span> <span
							class="teacher"><i class="fa-solid fa-user"></i> 강감찬</span> <span
							class="duration"><i class="fa-regular fa-hourglass-half"></i>
							${classInfo.classDays}
							<i class=""></i></span>
					</div>
				</div>
			</div>
					
		</section>
		
		<ul class="tabnav">
			<li><a href="#">클래스 소개</a></li>
			<li><a href="#">커리큘럼</a></li>
			<li><a href="#">수강평(1)</a></li>
			<li><a class="tab" href="CourseSupportList?class_id=2&codetype=CATE01">
			문의(0)
			</a></li>
		</ul>
		
		<div class="section-container">
		    <h1>클래스 상세 페이지</h1>
		    <h3 style="text-align: center; margin-bottom: 30px;">[ 클래스 상세 정보 ]</h3>
			
		    <input type="hidden" id="classIdx" name="classIdx" value="${classInfo.classIdx}"><br>
		
		    <div style="text-align: center; padding-top: 30px;">
		        <button class="orange-button" onclick="location.href='/course/user/classList?classType=${param.classType}&categoryIdx=${param.categoryIdx}'">
		        클래스 목록</button>
		        <c:if test="${user.userType eq 2 or user.userType eq 1}">
		            <button class="orange-button" onclick="location.href='/course/user/courseReservation?classIdx=${classInfo.classIdx}&classType=${param.classType}&categoryIdx=${param.categoryIdx}'">
		            예약정보 입력</button>
		        </c:if>
		    </div>
		</div>
		
		<jsp:include page="/WEB-INF/views/admin/bottom.jsp" />
		
	</div>
</body>
</html>