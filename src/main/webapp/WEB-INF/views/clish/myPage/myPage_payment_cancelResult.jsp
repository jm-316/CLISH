<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="ko">
	<head>
	    <meta charset="UTF-8" />
	    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    <title>결제취소정보</title>
	    <link rel='icon' href='/resources/images/logo4-2.png' type='image/x-icon'/>
	    
	    <script src="https://cdn.portone.io/v2/browser-sdk.js" async defer></script>
    
	</head>
	<body>
		<h1>취소정보</h1>
		<h3>
	 	${message } <br>
	 	결제 취소 번호 : ${paymentCancel.impUid } <br>
		결제 금액 : <fmt:formatNumber value="${paymentCancel.amount }" type="number" maxFractionDigits="0" /><br>
		결제 취소 금액 : <fmt:formatNumber value="${paymentCancel.cancelAmount }" type="number" maxFractionDigits="0" /><br>
	
	 	결제 취소 상태 : ${paymentCancel.status }<br>
	 	결제 취소 사유 : ${paymentCancel.cancelReason }<br>
	 	결제 취소 시간 : ${cancelTime}<br>
	 	회원 : ${paymentCancel.userName }<br>
	 	결제 방법 :${paymentCancel.payMethod }<br>
	 	결제 영수증 : <a href="${paymentCancel.receiptUrl }">결제영수증url</a><br>
	 	결제취소 영수증 : <a href="${paymentCancel.cancelReceiptUrl }">결제취소영수증url</a><br>
	 	</h3>
		<input type="button" value="확인" onclick="window.close()">
	</body>
</html>