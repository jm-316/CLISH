<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="preconnect" href="https://fonts.googleapis.com" >
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Nanum+Myeongjo&family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Orelega+One&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" >
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
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
		<div>
			<h3>예약 목록</h3>
			<table >
				<tr>
					<th>결제상태</th>
					<th>예약번호</th>
					<th>예약자</th>
					<th>클래스</th>
					<th>클래스예약일</th>
					<th>예약완료일</th>
					<th>취소</th>
					<th>결제</th>
					<th>상세보기</th>
				</tr>
				<!-- 예약  -->
				<c:forEach var="reserve" items="${reservationList }" >
		        	<tr>
		        		<td>
		        			<c:if test="${reserve.reservationStatus eq 1 }">미결제</c:if>
		        			<c:if test="${reserve.reservationStatus eq 2 }">결제완료</c:if>
		        		</td>
		        		<td>${reserve.reservationIdx}</td>
						<td>${user.userName}</td>
						<td>${reserve.classTitle}</td>
						<td>
							<fmt:parseDate var="reservationClassDate" 
								value="${reserve.reservationClassDate}"
								pattern="yyyy-MM-dd'T'HH:mm"
								type="both" />
							<fmt:formatDate value="${reservationClassDate}" pattern="yy-MM-dd"/>
						</td>
<%-- 							<td>${reserve.reservationClassDate}</td> --%>
						<td>
							<fmt:parseDate var="reservationCom" 
								value="${reserve.reservationCom}"
								pattern="yyyy-MM-dd'T'HH:mm:ss"
								type="both" />
							<fmt:formatDate value="${reservationCom}" pattern="yy-MM-dd HH:mm"/>
						</td>
<%-- 							<td>${reserve.reservationCom}</td> --%>
						<td><input type="button" value="취소" data-reservation-num="${reserve.reservationIdx}"
	          onclick="cancelReservation(this)" <c:if test="${reserve.reservationStatus eq 2 }">disabled</c:if>></td>
						<td><input type="button" value="결제" data-reservation-num="${reserve.reservationIdx}"
	          onclick="payReservation(this)" <c:if test="${reserve.reservationStatus eq 2 }">disabled</c:if>> </td>
						<td><input type="button" value="상세보기" data-reservation-num="${reserve.reservationIdx}"
	          onclick="reservationInfo(this)"> </td>
		        	</tr>

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
		
			<h3>결제 목록</h3>
			<table border="solid 1px">
				<tr>
					<th>결제 번호</th>
					<th>예약 번호</th>
					<th>결제 상태</th>
					<th>유저이름</th>
					<th>클래스명</th>
					<th>예약일</th>
					<th>결제완료시간</th>
					<th>취소</th>
					<th>상세보기</th>
				</tr>
				<jsp:useBean id="now" class="java.util.Date" scope="page" />
				<c:set var="nowTime" value="${now.time}" />
				<c:forEach var="payment" items="${paymentList }" >
		        	<tr>
		        		<td>${payment.impUid }</td>
		        		<td>${payment.reservationIdx}</td>
		        		<td>${payment.status }</td>
						<td>${payment.userName}</td>
						<td>${payment.classTitle}</td>
<%-- 						<td>${payment.reservationClassDate }</td> --%>
						<fmt:parseDate var="reservationClassDate" 
									value="${payment.reservationClassDate }"
									pattern="yyyy-MM-dd'T'HH:mm"
									type="both" />
						<td><fmt:formatDate value="${reservationClassDate}" pattern="yy-MM-dd"/></td>
						
						<%-- 현재날짜, 예약일자 계산, 예약일이 3일 미만으로 남았을 경우 취소 불가능 --%>
<%-- 						<c:set var="reservationTime" value="${reservationClassDate.time}" /> --%>
<%-- 						<c:set var="diffDays" value="${(reservationTime - nowTime) / (1000 * 60 * 60 * 24)}" /> --%>
<%-- 							<c:if test="${payment.status eq 'cancelled' || diffDays < 3 }">disabled</c:if> --%>
						<td>${payment.payTimeFormatted} </td>
						<td><input type="button" value="결제취소" data-imp-num="${payment.impUid}" onclick="cancelPayment(this)" 
							<c:if test="${payment.status eq 'cancelled' }"> disabled </c:if>></td>
						<td><input type="button" value="상세보기" data-imp-num="${payment.impUid}" data-status="${payment.status }"
	          onclick="paymentInfo(this)"> </td>
		        	</tr>
	       		</c:forEach>
			</table>
			<section id="paymentPageList">
				<c:if test="${not empty paymentPageInfo.maxPage or paymentPageInfo.maxPage > 0}">
					<input type="button" value="이전" 
						onclick="location.href='/myPage/payment_info?reservationPageNum=${reservationPageInfo.pageNum }&paymentPageNum=${paymentPageInfo.pageNum - 1}'" 
						<c:if test="${paymentPageInfo.pageNum eq 1}">disabled</c:if>
					>
					
					<c:forEach var="i" begin="${paymentPageInfo.startPage}" end="${paymentPageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq paymentPageInfo.pageNum}">
								<strong>${i}</strong>
							</c:when>
							<c:otherwise>
								<a href="/myPage/payment_info?reservationPageNum=${reservationPageInfo.pageNum}&paymentPageNum=${i}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<input type="button" value="다음" 
						onclick="location.href='/myPage/payment_info?reservationPageNum=${reservationPageInfo.pageNum}&paymentPageNum=${paymentPageInfo.pageNum + 1}'" 
						<c:if test="${paymentPageInfo.pageNum eq paymentPageInfo.maxPage}">disabled</c:if>
					>
				</c:if>
			</section>
		</div>
	
	</div>
	
	</main>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>

<script type="text/javascript">
	//취소버튼 함수
	function cancelReservation(btn) {
		if(confirm("정말로 예약을 취소하시겠습니까?")){
		    // 1. 버튼의 data- 속성에서 예약번호 읽기
		    var reservationIdx = btn.getAttribute('data-reservation-num');
// 			console.log(reservationIdx);
		    // 2. 필요하면 같은 행의 다른 정보도 읽을 수 있음
		    // var row = btn.closest('tr');
		    // var userId = row.cells[1].innerText;
		
		    // 3. 서버로 AJAX 전송 (fetch 사용)
		    fetch('/myPage/payment_info/cancel', {
		        method: 'POST',
		        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
		        body: 'reservationIdx=' + encodeURIComponent(reservationIdx)
		    })
		    .then(response => response.text())
		    .then(result => {
		        alert(result); // 서버에서 받은 결과 메시지 표시
		        location.reload(); // 필요하다면 새로고침
		    })
		    .catch(error => {
		        alert("오류 발생: " + error);
		    });
		}
	}
	
	//상세보기 버튼 함수
	function reservationInfo(btn) {
    	//예약번호 읽기
	    var reservationIdx = btn.getAttribute('data-reservation-num');
	    
		//팝업창 열기
	    window.open(
	        '/myPage/payment_info/detail?reservationIdx=' + encodeURIComponent(reservationIdx),
	        'reservationDetail',
	        `width=600,height=1500,resizable=yes,scrollbars=yes`
	    );
	}
	
	//결제버튼 함수
	function payReservation(btn) {
	    var reservationIdx = btn.getAttribute('data-reservation-num'); 
	    window.open(
	        '/myPage/payment_info/payReservation?from=list&reservationIdx=' + encodeURIComponent(reservationIdx),
	        'payReservation',
	        `width=600,height=1500,resizable=yes,scrollbars=yes`
	    );
	}
	
	function cancelPayment(btn) {
		var impUid = btn.getAttribute('data-imp-num');
		window.open(
			'/myPage/payment_info/cancelPayment?impUid=' + encodeURIComponent(impUid),			
			'paymentInfo',
			`width=600,height=1500, resizable=yes, scrollbars=yes`
		);
	}
	
	function paymentInfo(btn) {
		var impUid = btn.getAttribute('data-imp-num');
		var status = btn.getAttribute('data-status');
		console.log(status);
		if(status == 'paid'){
			window.open(
				'/myPage/payment_info/paymentDetail?impUid=' + encodeURIComponent(impUid),			
				'paymentInfo',
				`width=600,height=1500, resizable=yes, scrollbars=yes`
			);
		}
		if(status == 'cancelled'){
			window.open(
					'/myPage/payment_info/cancelDetail?impUid=' + encodeURIComponent(impUid),			
					'paymentInfo',
					`width=600,height=1500, resizable=yes, scrollbars=yes`
				);
		}
	}
	
	
</script>