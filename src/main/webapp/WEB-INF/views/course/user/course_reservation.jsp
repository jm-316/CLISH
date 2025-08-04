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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<script>
	// 카테고리 셀렉트 박스가 바뀌었을 때 함수 실행
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
		<jsp:include page="/WEB-INF/views/inc/top.jsp"/>
	</header>
		
	<jsp:include page="/WEB-INF/views/course/sidebar.jsp" />
	
	<div class="main">
		<%-- 클래스 예약 정보(날짜, 인원) 선택 --%>
		<form action="/course/user/reservationInfo" method="get">
			<div class="section-container">
			    <h1>클래스 예약 정보입력</h1>
			    <h3 style="text-align: center; margin-bottom: 30px;">[ 예약 상세 정보 ]</h3>
				
				<%-- 예약 가능 날짜만 보여주기 --%>			    
    			예약 날짜: <input type="date" name="reservationClassDateRe" min="${classInfo.startDate}" max="${classInfo.endDate}" required/><br>
			    예약 인원: <input type="text" name="reservationMembers" required /><br>
			    
				<%-- 유저정보와 클래스 정보를 INSERT 하기 위해서 hidden으로 전달 --%>			    
			    <input type="hidden" id="userIdx" name="userIdx" value="${userInfo.userIdx}"><br>
			    <input type="hidden" id="classIdx" name="classIdx" value="${classInfo.classIdx}"><br>
			    
			    <section id="classDetail">
					${classInfo.classContent } <hr>
					<h1>클래스상세정보 이미지 표시란</h1>
					<c:forEach var="file" items="${classInfo.fileList}">
						파일이름 : ${file.originalFileName} <br>
						파일 서브 디렉토리 :${file.subDir} <br>
						진짜 파일 이름 : ${file.realFileName}<br>
						<img width="100%" 
							src="/resources/upload/${file.subDir}/${file.realFileName}" alt="${file.originalFileName}"/>
					</c:forEach>
			    </section>
				
				<section id="curriCulum">
				<h1>커리큘럼정보</h1>
					<c:forEach var="curri" items="${curriculumList}">
						${curri.curriculumTitle}, ${curri.curriculumRuntime} <br>
					
					</c:forEach>
				</section>
				
				<section id="reView">
					<h1>수강후기</h1>
					<c:forEach var="review" items="${reviewList}" varStatus="status">
						<table>
						<tr>
							<th>작성자</th>
							<td>${review.userName}(${review.userId})</td>
							<th>평점</th>
							<td>
								<div class="star-rating" data-index="${status.index}">
									<span class="star">&#9733;</span>
									<span class="star">&#9733;</span>
									<span class="star">&#9733;</span>
									<span class="star">&#9733;</span>
									<span class="star">&#9733;</span>
									<input type="hidden" id="score_${status.index}" name="reviewScore" value="${review.reviewScore}" />
								</div>
							</td>
						</tr>
						<tr class="review-detail">
							<th>제목</th>
							<td colspan="3">${review.reviewTitle}</td>								
						</tr>
						<tr class="review-detail">
							<th>내용</th>
							<td colspan="3" width="30">${review.reviewDetail}</td>
						</tr>
						<tr class="review-detail">
							<th>첨부사진</th>
							<td colspan="3" width="30">
								<c:forEach var="file" items="${review.fileList}">
									<img class="img-thumb"
										src="${pageContext.request.contextPath}/resources/upload/${file.subDir}/${file.realFileName}" alt="${file.originalFileName}" />					
								</c:forEach>
							</td>
						</tr>
						</table>
					</c:forEach>
				</section>
			</div>
		
			<div style="text-align: center; padding-top: 30px; display: flex;">
				<c:if test="${not empty param.classType}">
		           	<button class="orange-button" onclick="location.href='/course/user/classList?classType=${param.classType}&categoryIdx=${param.categoryIdx}'">
		           	클래스 목록</button>
				</c:if>
				<%-- 신청가능한 클래스이고 일반 유저일 경우 예약 확정 버튼 표시 --%>
				<c:if test="${userInfo.userType eq 1 and classInfo.classStatus eq 2}">
		            <button type="submit" class="orange-button" onclick="alert('결제 대기 시간은 2시간입니다.')">수강 신청</button>
				</c:if>
			</div>
		</form>
	</div>
	
	<%-- 클래스 등록 이미지 보여주기 --%>
	<div id="imgModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.7); text-align:center;">
  		<img id="modalImg" src="" alt="원본" style="max-width:90vw; max-height:90vh; margin-top:5vh; border:3px solid #fff;" />
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
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



