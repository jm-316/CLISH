<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 문의</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com" >
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Nanum+Myeongjo&family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Orelega+One&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" >
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<style>
	.inquery-toggle { cursor: pointer; background: #f9f9f9; }
	.inquery-detail { display: none; background: #fff4d9; }
	.btn-wrap {
	  display: flex;
	  gap: 16px;
	  margin-top: 10px;
	}
	.btn-wrap form {
	  margin: 0;
	  padding: 0;
	  border: none;         /* 폼 기본 테두리 제거 */
	  background: none;     /* 배경도 없앰 */
	  box-shadow: none;     /* 박스 그림자 효과도 제거 */
	  display: inline;      /* 불필요한 block 배치 없애기 */
	}
	.btn-wrap button:hover {
	  background: #ff9c34;
	}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<main id="container">
	
	<jsp:include page="/WEB-INF/views/clish/myPage/side.jsp"></jsp:include>
	
	<div id="main">
	
		<h1>${sessionScope.sId}의 페이지</h1>
		<hr>
		<h3>나의문의목록</h3>
<!-- 		<input type="hidden" id="parent" value="list"> -->
		<div>
			<h3>강좌 문의</h3>
			<table border="solid 1px">
				<tr>
					<th>결제상태</th>
					<th>예약번호</th>
					<th>예약자</th>
					<th>클래스아이디</th>
					<th>예약요청일</th>
					<th>예약완료일</th>
					<th>취소</th>
					<th>결제</th>
					<th>상세보기</th>
				</tr>
				<c:forEach var="reserve" items="${reservationList }" >
					<c:if test="${reserve.reservationStatus == 1}">
			        	<tr>
			        		<td><c:if test="${reserve.reservationStatus eq 1 }">미결제</c:if></td>
			        		<td>${reserve.reservationIdx}</td>
							<td>${user.userName}</td>
							<td>${reserve.classIdx}</td>
							<td>${reserve.reservationClassDate}</td>
							<td>${reserve.reservationCom}</td>
							<td><input type="button" value="취소" data-reservation-num="${reserve.reservationIdx}"
		          onclick="cancelReservation(this)"></td>
							<td><input type="button" value="결제" data-reservation-num="${reserve.reservationIdx}"
		          onclick="payReservation(this)"> </td>
							<td><input type="button" value="상세보기" data-reservation-num="${reserve.reservationIdx}"
		          onclick="reservationInfo(this)"> </td>
			        	</tr>
			        </c:if>
			        <c:if test="${reserve.reservationStatus == 2}">
			        	<tr>
			        		<td><c:if test="${reserve.reservationStatus eq 2 }">결제완료</c:if></td>
			        		<td>${reserve.reservationIdx}</td>
							<td>${user.userName}</td>
							<td>${reserve.classIdx}</td>
							<td>${reserve.reservationClassDate}</td>
							<td>${reserve.reservationCom}</td>
							<td></td><td></td>
							<td><input type="button" value="상세보기" data-reservation-num="${reserve.reservationIdx}"
		          onclick="reservationInfo(this)"> </td>
			        	</tr>
			        </c:if>
	       		</c:forEach>
			</table>
			<section id="reservationPageList">
				<c:if test="${not empty reservationPageInfo.maxPage or reservationPageInfo.maxPage > 0}">
					<input type="button" value="이전" 
						onclick="location.href='/myPage/payment_info?reservationPageNum=${reservationPageInfo.pageNum - 1}&paymentPageNum=${paymentPageInfo.pageNum }'" 
						<c:if test="${reservationPageInfo.pageNum eq 1}">disabled</c:if>
					>
					
					<c:forEach var="i" begin="${reservationPageInfo.startPage}" end="${reservationPageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq reservationPageInfo.pageNum}">
								<strong>${i}</strong>
							</c:when>
							<c:otherwise>
								<a href="/myPage/payment_info?reservationPageNum=${i}&paymentPageNum=${paymentPageInfo.pageNum }">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<input type="button" value="다음" 
						onclick="location.href='/myPage/payment_info?reservationPageNum=${reservationPageInfo.pageNum + 1}&paymentPageNum=${paymentPageInfo.pageNum }'" 
						<c:if test="${reservationPageInfo.pageNum eq reservationPageInfo.maxPage}">disabled</c:if>
					>
				</c:if>
			</section>
		</div>
		<div>
			<h3>사이트 문의</h3>
			<table border="1" style="width: 100%; border-collapse: collapse;">
				<thead style="background-color: #f5f5f5;">
	   			<tr>
	      			<th>문의 번호</th>
				    <th>이름</th>
				    <th>제목</th>
				    <th>상태</th>
			    </tr>
			    </thead>
			  	<tbody>
				  	<c:forEach var="inquery" items="${inqueryDTOList}">
					    <tr class="inquery-toggle">
					    	<td>${inquery.inqueryIdx}</td>
					      	<td>${user.userName}</td>
					      	<td>${inquery.inqueryTitle}</td>
					      	<td>
					        <c:choose>
					        	<c:when test="${inquery.inqueryStatus == 1}">답변대기</c:when>
					          	<c:when test="${inquery.inqueryStatus == 2}">답변완료</c:when>
					       	 	<c:when test="${inquery.inqueryStatus == 3}">검토중</c:when>
					        </c:choose>
					     	</td>
					    </tr>
					
					    <tr class="inquery-detail">
					      	<td colspan="4">
						        <strong>문의 내용:</strong><br>
						        	${inquery.inqueryDetail}<br><br>
						        <strong>답변 내용:</strong><br>
						        <c:if test="${not empty inquery.inqueryAnswer}">
						        	  ${inquery.inqueryAnswer}
						        </c:if>
						        <c:if test="${empty inquery.inqueryAnswer}">
						         	 아직 답변이 등록되지 않았습니다.
						        </c:if>
						
						        <c:if test="${inquery.inqueryStatus == 1}">
						          	<div class="btn-wrap">
							            <form action="/myPage/myQuestion/inquery/modify" method="get" style="display:inline;">
							            	<input type="hidden" name="inqueryIdx" value="${inquery.inqueryIdx}">
							            	<button type="submit">수정</button>
							            </form>
							            <form action="/myPage/myQuestion/inquery/delete" method="post" style="display:inline;">
							              	<input type="hidden" name="inqueryIdx" value="${inquery.inqueryIdx}">
							              	<button type="submit" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
							            </form>
						          	</div>
						        </c:if>
					    	</td>
					    </tr>
				  	</c:forEach>
			  	</tbody>
		  	</table>
			<section id="inqueryList">
				<c:if test="${not empty inqueryPageInfo.maxPage or inqueryPageInfo.maxPage > 0}">
					<input type="button" value="이전" 
						onclick="location.href='/myPage/myQuestion?classQuestionPageNum=${classQuestionPageInfo.pageNum }&inqueryPageNum=${inqueryPageInfo.pageNum - 1}'" 
						<c:if test="${inqueryPageInfo.pageNum eq 1}">disabled</c:if>
					>
					
					<c:forEach var="i" begin="${inqueryPageInfo.startPage}" end="${inqueryPageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq inqueryPageInfo.pageNum}">
								<strong>${i}</strong>
							</c:when>
							<c:otherwise>
								<a href="/myPage/myQuestion?classQuestionPageNum=${classQuestionPageInfo.pageNum}&inqueryPageNum=${i}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<input type="button" value="다음" 
						onclick="location.href='/myPage/myQuestion?classQuestionPageNum=${classQuestionPageInfo.pageNum}&inqueryPageNum=${inqueryPageInfo.pageNum + 1}'" 
						<c:if test="${inqueryPageInfo.pageNum eq inqueryPageInfo.maxPage}">disabled</c:if>
					>
				</c:if>
			</section>
		</div>
	
	</div>
	
	</main>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script>
	  $(document).ready(function () {
	    $(".inquery-toggle").click(function () {
	      const detailRow = $(this).next(".inquery-detail");
	
	      // 모든 detail 닫고, 클릭 대상이 닫혀있던 거면 열기
	      $(".inquery-detail").not(detailRow).slideUp(200);
	
	      if (!detailRow.is(":visible")) {
	        detailRow.slideDown();
	      } else {
	        detailRow.slideUp();
	      }
	    });
	  });
	</script>
</body>
</html>