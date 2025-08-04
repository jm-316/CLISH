<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Clish</title>
<link rel="preconnect" href="https://fonts.googleapis.com" >
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Nanum+Myeongjo&family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Orelega+One&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/main.css" >
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<link rel='icon' href='${pageContext.request.contextPath}/resources/images/logo4-2.png' type='image/x-icon'/>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include> 
	</header>
<!-- 	<h1>Main.jsp</h1> -->
	
		<div id="event" onclick="location.href='/event/event_detail/EVT20250804112506'"></div>
	<div class="h2-flexbox">
		<h2>추천 정기 강의</h2>
		<div id="class-filter-wrapper">
			<div class="class-filter">
				<button onclick="location.href='/course/user/classList?classType=0'">필터</button>
				
<!-- 				<button>높은 가격</button><button>낮은 가격</button> -->
			</div>
		</div>
	</div>
<!-- 		carousel from: https://codepen.io/CalculateQuick/pen/qEEZRmN -->
	<div class="carousel">
	<div class="carousel-track">
		<c:forEach var="course" items="${classList2}">
			<article class="deconstructed-card" onclick="location.href='/course/user/classDetail?classIdx=${course.classIdx}&classType=${course.classType}&categoryIdx=${course.categoryIdx}'">
	
					<div class="content-fragment fragment-heading">
						<h3 class="content-text">${course.classTitle}</h3>
					</div>
					<div class="small-thumbnail">  
					<c:choose>
					    <c:when test="${empty course.classPic1}">
					        <img src="${pageContext.request.contextPath}/resources/images/example_thumbnail.jpg" alt="${course.classTitle}" >
					    </c:when>
					    <c:otherwise>
					        <img src="${course.classPic1}" alt="${course.classTitle}" >
					    </c:otherwise>
					</c:choose>
						
 				    </div> 
					<div class="content-fragment fragment-meta">
						<div class="meta-line"></div>
						<span class="meta-text">	
						<script type="text/javascript"> 
							(function () {
								let courseCategory = "${course.categoryIdx}";
								let modifiedCategory = courseCategory.substring(3).replace(/_/g, " ");
								document.write(modifiedCategory);
							})();
						</script>
						</span>
					</div>
					<div class="content-fragment fragment-meta">
<!-- 						<div class="meta-line"></div> -->
						<p class="">강의 기간 : ${course.classDays}  일</p>
					</div>

					<div class="content-fragment fragment-body">
						<p class="description-text">${course.classIntro}</p>
					</div>
					<div class="content-fragment fragment-body">
						<p class=" orange-tag">${course.location}</p>
					</div>
					<div class="content-fragment fragment-meta">
<!-- 						<div class="meta-line"></div> -->
						<span class="meta-text">	
						<script type="text/javascript">
							(function () {
			 					let coursePrice = "${course.classPrice}";
			 					let stopIndex = coursePrice.indexOf(".");
			 					let modifiedPrice = coursePrice.substring(0, stopIndex);
			 					let modifiedPriceComma = Number(modifiedPrice).toLocaleString('ko-KR');
			 					document.write(modifiedPriceComma);
			 					})(); 
						</script> 원
						</span>
					</div>				
				</article>
		</c:forEach>
			</div>
			
		
		
	
		<div class="carousel-controls">
			<button class="carousel-button prev">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<polyline points="15 18 9 12 15 6"></polyline>
				</svg>
			</button>
			<button class="carousel-button next">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<polyline points="9 18 15 12 9 6"></polyline>
				</svg>
			</button>
		</div>
	
		<div class="dots-container"></div>
	</div>
	<div class="h2-flexbox">
		<h2>추천 단기 강의</h2>
		<div id="class-filter-wrapper">
			<div class="class-filter">
					<button onclick="location.href='/course/user/classList?classType=1'">필터</button>			
			</div>
		</div>
	</div>
<!-- 		carousel from: https://codepen.io/CalculateQuick/pen/qEEZRmN -->
	<div class="carousel">
	<div class="carousel-track">
		<c:forEach var="course" items="${classList}">
			<article class="deconstructed-card" onclick="location.href='/course/user/classDetail?classIdx=${course.classIdx}&classType=${course.classType}&categoryIdx=${course.categoryIdx}'">
	
					<div class="content-fragment fragment-heading">
						<h3 class="content-text">${course.classTitle}</h3>
					</div>
					<div class="small-thumbnail">  
					<c:choose>
					    <c:when test="${empty course.classPic1}">
					        <img src="${pageContext.request.contextPath}/resources/images/example_thumbnail.jpg" alt="${course.classTitle}" >
					    </c:when>
					    <c:otherwise>
					        <img src="${course.classPic1}" alt="${course.classTitle}" >
					    </c:otherwise>
					</c:choose>
						
 				    </div> 
					<div class="content-fragment fragment-meta">
						<div class="meta-line"></div>
						<span class="meta-text">	
						<script type="text/javascript"> 
							(function () {
								let courseCategory = "${course.categoryIdx}";
								let modifiedCategory = courseCategory.substring(3).replace(/_/g, " ");
								document.write(modifiedCategory);
							})();
						</script>
						</span>
					</div>
					<div class="content-fragment fragment-meta">
<!-- 						<div class="meta-line"></div> -->
						<p class="">강의 기간 : ${course.classDays}  일</p>
					</div>

					<div class="content-fragment fragment-body">
						<p class="description-text">${course.classIntro}</p>
					</div>
					<div class="content-fragment fragment-body">
						<p class=" orange-tag">${course.location}</p>
					</div>
					<div class="content-fragment fragment-meta">
<!-- 						<div class="meta-line"></div> -->
						<span class="meta-text">	
						<script type="text/javascript">
							(function () {
			 					let coursePrice = "${course.classPrice}";
			 					let stopIndex = coursePrice.indexOf(".");
			 					let modifiedPrice = coursePrice.substring(0, stopIndex);
			 					let modifiedPriceComma = Number(modifiedPrice).toLocaleString('ko-KR');
			 					document.write(modifiedPriceComma);
			 					})(); 
						</script> 원
						</span>
					</div>
					
				</article>
		</c:forEach>
			</div>
			
		
		
	
		<div class="carousel-controls">
			<button class="carousel-button prev">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<polyline points="15 18 9 12 15 6"></polyline>
				</svg>
			</button>
			<button class="carousel-button next">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<polyline points="9 18 15 12 9 6"></polyline>
				</svg>
			</button>
		</div>
	
		<div class="dots-container"></div>
	</div>
	
	<h2>신규 정기 강의</h2>
<!-- 		carousel from: https://codepen.io/CalculateQuick/pen/qEEZRmN -->
	<div class="carousel">
	<div class="carousel-track">
		<c:forEach var="course" items="${classListLongLatest}">
			<article class="deconstructed-card" onclick="location.href='/course/user/classDetail?classIdx=${course.classIdx}&classType=${course.classType}&categoryIdx=${course.categoryIdx}'">
	
					<div class="content-fragment fragment-heading">
						<h3 class="content-text">${course.classTitle}</h3>
					</div>
					<div class="small-thumbnail">  
					<c:choose>
					    <c:when test="${empty course.classPic1}">
					        <img src="${pageContext.request.contextPath}/resources/images/example_thumbnail.jpg" alt="${course.classTitle}" >
					    </c:when>
					    <c:otherwise>
					        <img src="${course.classPic1}" alt="${course.classTitle}" >
					    </c:otherwise>
					</c:choose>
						
 				    </div> 
					<div class="content-fragment fragment-meta">
						<div class="meta-line"></div>
						<span class="meta-text">	
						<script type="text/javascript"> 
							(function () {
								let courseCategory = "${course.categoryIdx}";
								let modifiedCategory = courseCategory.substring(3).replace(/_/g, " ");
								document.write(modifiedCategory);
							})();
						</script>
						</span>
					</div>
					<div class="content-fragment fragment-meta">
<!-- 						<div class="meta-line"></div> -->
						<p class="">강의 기간 : ${course.classDays}  일</p>
					</div>

					<div class="content-fragment fragment-body">
						<p class="description-text">${course.classIntro}</p>
					</div>
					<div class="content-fragment fragment-body">
						<p class=" orange-tag">${course.location}</p>
					</div>
					<div class="content-fragment fragment-meta">
<!-- 						<div class="meta-line"></div> -->
						<span class="meta-text">	
						<script type="text/javascript">
							(function () {
			 					let coursePrice = "${course.classPrice}";
			 					let stopIndex = coursePrice.indexOf(".");
			 					let modifiedPrice = coursePrice.substring(0, stopIndex);
			 					let modifiedPriceComma = Number(modifiedPrice).toLocaleString('ko-KR');
			 					document.write(modifiedPriceComma);
			 					})(); 
						</script> 원
						</span>
					</div>
					
				</article>
		</c:forEach>
			</div>
			
		
		
	
		<div class="carousel-controls">
			<button class="carousel-button prev">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<polyline points="15 18 9 12 15 6"></polyline>
				</svg>
			</button>
			<button class="carousel-button next">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<polyline points="9 18 15 12 9 6"></polyline>
				</svg>
			</button>
		</div>
	
		<div class="dots-container"></div>
	</div>
	
	<h2>신규 단기 강의</h2>
<!-- 		carousel from: https://codepen.io/CalculateQuick/pen/qEEZRmN -->
	<div class="carousel">
	<div class="carousel-track">
		<c:forEach var="course" items="${classListShortLatest}">
			<article class="deconstructed-card" onclick="location.href='/course/user/classDetail?classIdx=${course.classIdx}&classType=${course.classType}&categoryIdx=${course.categoryIdx}'">
	
					<div class="content-fragment fragment-heading">
						<h3 class="content-text">${course.classTitle}</h3>
					</div>
					<div class="small-thumbnail">  
					<c:choose>
					    <c:when test="${empty course.classPic1}">
					        <img src="${pageContext.request.contextPath}/resources/images/example_thumbnail.jpg" alt="${course.classTitle}" >
					    </c:when>
					    <c:otherwise>
					        <img src="${course.classPic1}" alt="${course.classTitle}" >
					    </c:otherwise>
					</c:choose>
						
 				    </div> 
					<div class="content-fragment fragment-meta">
						<div class="meta-line"></div>
						<span class="meta-text">	
						<script type="text/javascript"> 
							(function () {
								let courseCategory = "${course.categoryIdx}";
								let modifiedCategory = courseCategory.substring(3).replace(/_/g, " ");
								document.write(modifiedCategory);
							})();
						</script>
						</span>
					</div>
					<div class="content-fragment fragment-meta">
<!-- 						<div class="meta-line"></div> -->
						<p class="">강의 기간 : ${course.classDays}  일</p>
					</div>

					<div class="content-fragment fragment-body">
						<p class="description-text">${course.classIntro}</p>
					</div>
					<div class="content-fragment fragment-body">
						<p class=" orange-tag">${course.location}</p>
					</div>
					<div class="content-fragment fragment-meta">
<!-- 						<div class="meta-line"></div> -->
						<span class="meta-text">	
						<script type="text/javascript">
							(function () {
			 					let coursePrice = "${course.classPrice}";
			 					let stopIndex = coursePrice.indexOf(".");
			 					let modifiedPrice = coursePrice.substring(0, stopIndex);
			 					let modifiedPriceComma = Number(modifiedPrice).toLocaleString('ko-KR');
			 					document.write(modifiedPriceComma);
			 					})(); 
						</script> 원
						</span>
					</div>
					
				</article>
		</c:forEach>
			</div>
			
		
		
	
		<div class="carousel-controls">
			<button class="carousel-button prev">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<polyline points="15 18 9 12 15 6"></polyline>
				</svg>
			</button>
			<button class="carousel-button next">
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<polyline points="9 18 15 12 9 6"></polyline>
				</svg>
			</button>
		</div>
	
		<div class="dots-container"></div>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include> 
	</footer>

	



</body>
</html>