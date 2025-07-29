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
<style type="text/css">
	.star {
		font-size: 30px;
		color: #ccc; /* 비활성 별 색 */
	}
	
	.star.active {
		color: gold; /* 활성 별 색 */
	}

	.img-thumb {
	  width: 100px;      /* 썸네일 너비 */
	  height: auto;      /* 원본 비율 유지 */
	  cursor: pointer;   /* 마우스 올리면 손모양 */
	  border: 1px solid #ddd;
	  margin: 5px;
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<jsp:include page="/WEB-INF/views/course/sidebar.jsp" />
	
	<div class="main">
		
		<section class="breadcrumb">
            <a href="#">카테고리</a> <i class="fa-solid fa-angle-right"></i>
            <a href="classList?classType=${param.classType}">IT/개발</a> <i class="fa-solid fa-angle-right"></i>
            <a href="classList?classType=${param.classType}&categoryIdx=${param.categoryIdx}">
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
	    <div style="text-align: center; padding-top: 30px; display: flex;">
	        <button class="orange-button" onclick="location.href='/course/user/classList?classType=${param.classType}&categoryIdx=${param.categoryIdx}'">
	        클래스 목록</button>
	        <c:if test="${user.userType eq 2 or user.userType eq 1}">
	            <button class="orange-button" onclick="location.href='/course/user/courseReservation?classIdx=${classInfo.classIdx}&classType=${param.classType}&categoryIdx=${param.categoryIdx}'">
	            예약정보 입력</button>
	        </c:if>
	    </div>
					
		</section>
		
		<ul class="tabnav" style="text-align: center; padding-top: 30px; display: flex;">
			<li><a href="#classDetail">클래스 소개</a></li>
			<li><a href="#curriCulum">커리큘럼</a></li>
			<li><a href="#reView">수강평(1)</a></li>
			<li><a class="tab" href="CourseSupportList?class_id=2&codetype=CATE01">
			문의(0)
			</a></li>
		</ul>
		
		<div class="section-container">
		    <h1>클래스 상세 페이지</h1>
		    <h3 style="text-align: center; margin-bottom: 30px;">[ 클래스 상세 정보 ]</h3>
		    <input type="hidden" id="classIdx" name="classIdx" value="${classInfo.classIdx}"><br>
		    <section id="classDetail">
				${classInfo.classContent } <hr>
				<h1>클래스 컨텐츠 출력칸</h1>
				<c:forEach var="file" items="${classInfo.fileList }">
					파일이름 : ${file.originalFileName } <br>
					파일 서브 디렉토리 :${file.subDir} <br>
					진짜 파일 이름 : ${file.realFileName }<br>
					<img width="100%" 
						src="/resources/upload/${file.subDir}/${file.realFileName}" alt="${file.originalFileName }"/>
				</c:forEach>
		    </section>
			
			<section id="curriCulum">
			<h1>커리큘럼정보</h1>
				<c:forEach var="curri" items="${curriculumList }">
					${curri.curriculumTitle }, ${curri.curriculumRuntime } <br>
				
				</c:forEach>
			</section>
			
			<section id="reView">
				<h1>수강후기</h1>
				<c:forEach var="review" items="${reviewList }" varStatus="status">
					<table>
					<tr>
						<th>작성자</th>
						<td>${review.userName }(${review.userId })</td>
						<th>평점</th>
						<td>
							<div class="star-rating" data-index="${status.index }">
								<span class="star">&#9733;</span>
								<span class="star">&#9733;</span>
								<span class="star">&#9733;</span>
								<span class="star">&#9733;</span>
								<span class="star">&#9733;</span>
								<input type="hidden" id="score_${status.index }" name="reviewScore" value="${review.reviewScore }" />
							</div>
						</td>
					</tr>
					<tr class="review-detail">
						<th>제목</th>
						<td colspan="3">${review.reviewTitle }</td>								
					</tr>
					<tr class="review-detail">
						<th>내용</th>
						<td colspan="3" width="30">${review.reviewDetail }</td>
					</tr>
					<tr class="review-detail">
						<th>첨부사진</th>
						<td colspan="3" width="30">
							<c:forEach var="file" items="${review.fileList }">
								<img class="img-thumb"
									src="${pageContext.request.contextPath}/resources/upload/${file.subDir}/${file.realFileName}" alt="${file.originalFileName }" />					
							</c:forEach>
						</td>
					</tr>
					</table>
				</c:forEach>
				<section id="classReviewPageList">
					<c:if test="${not empty pageInfo.maxPage or pageInfo.maxPage > 0}">
						<input type="button" value="이전" 
							onclick="location.href='/course/user/classDetail?classIdx=${param.classIdx }&classType=${param.classType }&categoryIdx=${param.categoryIdx }&reviewPageNum=${pageInfo.pageNum - 1}#reView'" 
							<c:if test="${pageInfo.pageNum eq 1}">disabled</c:if>
						>
						
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<c:choose>
								<c:when test="${i eq pageInfo.pageNum}">
									<strong>${i}</strong>
								</c:when>
								<c:otherwise>
									<a href="/course/user/classDetail?classIdx=${param.classIdx }&classType=${param.classType }&categoryIdx=${param.categoryIdx }&reviewPageNum=${i}#reView">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<input type="button" value="다음" 
							onclick="location.href='/course/user/classDetail?classIdx=${param.classIdx }&classType=${param.classType }&categoryIdx=${param.categoryIdx }&reviewPageNum=${pageInfo.pageNum + 1}#reView'" 
							<c:if test="${pageInfo.pageNum eq pageInfo.maxPage}">disabled</c:if>
						>
					</c:if>
				</section>
			</section>
		
		
		</div>
	</div>
	
	<div id="imgModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.7); text-align:center;">
  		<img id="modalImg" src="" alt="원본" style="max-width:90vw; max-height:90vh; margin-top:5vh; border:3px solid #fff;" />
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(function(){
			//평점보여주기
			$(".star-rating").each(function() {
				var $container = $(this);
				var index = $container.data("index");
				var score = parseInt($("#score_" + index).val(), 10);
				
				$container.children(".star").each(function(i){
			      if(i < score){
			        $(this).addClass("active");
			      } else {
			        $(this).removeClass("active");
			      }
			    });
			})
			//이미지 크기
			$(function(){
			  // 썸네일 클릭 시 원본 큰 이미지 보여줌
				$(document).on("click", ".img-thumb", function(e) {
				    var src = $(this).attr("src");
				    $("#modalImg").attr("src", src);
				    $("#imgModal").fadeIn(200);
				});
			  
				// 모달 바깥 클릭 or 이미지 클릭 시 닫기
				$("#imgModal").on("click", function(){
				    $(this).fadeOut(200);
				    $("#modalImg").attr("src", "");
				});
			});
		});
	</script>
</body>
</html>