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
		
		<form action="myPage/reservationInfo" method="get">
			<div class="section-container">
			    <h1>클래스 예약 정보입력 페이지</h1>
			    <h3 style="text-align: center; margin-bottom: 30px;">[ 예약 상세 정보 ]</h3>
			    
    			날짜: <input type="date" name="reservationClassDate" required /><br/>
			    예약 인원: <input type="text" name="reservationMembers" required /><br/>
			    
			    <input type="hidden" id="classIdx" name="classIdx" value="${classInfo.classIdx}"><br>
			    <section id="classDetail">
					${classInfo.classContent } <hr>
					<h1>클래스상세정보 이미지 표시란</h1>
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
		
		
		</div >
		
		<div style="text-align: center; padding-top: 30px; display: flex;">
			<c:if test="${not empty param.classType}">
	           	<button class="orange-button" onclick="location.href='/course/user/classList?classType=${param.classType}&categoryIdx=${param.categoryIdx}'">
	           	클래스 목록</button>
			</c:if>
            <button type="submit" class="orange-button" onclick="alert('결제 대기 시간은 2시간입니다.')">예약 확정</button>
		</div>
		</form>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/admin/bottom.jsp" />
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



