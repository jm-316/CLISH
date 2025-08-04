<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제창</title>
<link href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/myPage.css" rel="stylesheet" type="text/css">
<!-- jQuery와 포트원 결제 SDK 로드 -->
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- <script src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script> -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/myPage/myPage_payment.js"></script>

</head>
<body>

	<main id="container">
	
	<div id="main">
		<form action="" method="post">
		<table style="margin-left: auto ; margin-right: auto;">
			<tr>
				<th rowspan="5">
					<img src="/file/${reservationClassInfo.file_id}?type=0"
					 alt="${reservationClassInfo.original_file_name }" width="200px" height="250px" >
				</th>
				<th>${reservationClassInfo.class_title}</th>
			</tr>
			<tr><th>클래스정원</th></tr>
			<tr>
				<th>${reservationClassInfo.class_member}</th>
			</tr>
			<tr><th>남은자리</th></tr> 
			<tr>
				<th>${reservationClassInfo.remainSeats}</th>
			</tr>
			<tr><th>시작일</th><th>종료일</th></tr>
			<tr>
				<th>${reservationClassInfo.start_date}</th>
				<th>${reservationClassInfo.end_date}</th>
			</tr> 
		</table>
		<table >
			<tr>
				<th>예약번호</th>
				<th>예약자</th>
				<th>클래스명</th>
				<th>예약요청일</th>
				<th>예약완료일</th>
				<th>잔여좌석</th>
				<th>예약인원</th>
				<th>결제 금액</th>
			</tr>
        	<tr>
        		<td>${reservationClassInfo.reservation_idx}</td>
				<td>${user.userName}</td>
				<td>${reservationClassInfo.class_title}</td>
				<fmt:parseDate var="reservationClassDate" 
					value="${reservationClassInfo.reservation_class_date}"
					pattern="yyyy-MM-dd'T'"
					type="both" />
				<td><fmt:formatDate value="${reservationClassDate}" pattern="yy-MM-dd "/></td>
				<fmt:parseDate var="reservationCom" 
					value="${reservationClassInfo.reservation_com}"
					pattern="yyyy-MM-dd'T'HH:mm:ss"
					type="both" />
				<td><fmt:formatDate value="${reservationCom}" pattern="yy-MM-dd HH:mm"/></td>
				<td>${reservationClassInfo.remainSeats}</td>
				<td>${reservationClassInfo.reservation_members}</td>
				<td><fmt:formatNumber pattern="#,##0">${reservationClassInfo.reservation_members * reservationClassInfo.class_price}</fmt:formatNumber>
				 </td>		
        	</tr>
			<tr>
				<td colspan="8" style="text-align: right;">
					<input type="button" value="취소" data-reservation-num="${reservationClassInfo.reservation_idx}"
	         				onclick="cancelPayment(this)">
					<input type="button" value="결제" data-reservation-num="${reservationClassInfo.reservation_idx}"
						onclick="requestPay()" id="paybtn">
       			</td>
       		</tr> 
		</table>
		</form>
	</div>
	
	</main>
	
	<script type="text/javascript">
	
		var reservation_idx = "${reservationClassInfo.reservation_idx}";
		var reservation_class_date = "${reservationClassInfo.reservation_class_date}";
		var reservation_com = "${reservationClassInfo.reservation_com}";
		var class_price = "${reservationClassInfo.class_price}";
		var reservation_members = "${reservationClassInfo.reservation_members}";
		var price = "${reservationClassInfo.reservation_members * reservationClassInfo.class_price}";
		var class_title = "${reservationClassInfo.class_title}";
		var user_name = "${user.userName}";
		var from = "${param.from}";
		
		function cancelPayment(btn) {
			if(confirm("결제를 취소하시겠습니까?")){
			    window.close();
			}
		}	
		
		// PC/모바일 환경 구분 함수
		// navigator.userAgent : 사용자의 브라우저, 운영체제, 기기 정보
		// /Mobi|Android|iPhone|iPad/i "Mobi","Android", "iPhone", "iPad" 이라는 단어가 들어있는지 검사 /i
		// .test() navigator.userAgent에 위의 단어가 포함되어있는지 검사, true false 리턴
		function isMobile() {
		  return /Mobi|Android|iPhone|iPad/i.test(navigator.userAgent);
		}
		
		window.onunload = function() {
		    if (window.opener && !window.opener.closed) {
		        window.opener.location.reload();
		    }
		    if (window.opener.opener && !window.opener.opener.closed) {
		        window.opener.opener.location.reload();
		    }
		};
	// 	//테스트를 위한 난수생성
	// 	function getRandomString(length) {
	// 	  return Math.random().toString(36).substr(2, length);
	// 	}
		
	// 	const randomStr = getRandomString(8);
		
	</script>

</body>
</html>


