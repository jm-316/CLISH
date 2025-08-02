<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="ko">
	<head>
	    <meta charset="UTF-8" />
	    <link rel="icon" type="image/png" href="/favicon.png" />
	    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    <title>결제정보</title>
	    <script src="https://cdn.portone.io/v2/browser-sdk.js" async defer></script>
	</head>
	<body>
	    <h1>결제완료</h1>
		<h3>
			결제 번호 : ${paymentInfoDTO.impUid }<br>
			상품 이름 : ${paymentInfoDTO.classTitle}<br>
			주문 번호 : ${paymentInfoDTO.reservationIdx}<br>
			결제 금액 : <fmt:formatNumber value="${paymentInfoDTO.amount }" type="number" maxFractionDigits="0" /><br>
			구매 I  D : ${paymentInfoDTO.userName }<br>
			구매 상태 : ${paymentInfoDTO.status }<br>
			결제 시각 : ${payTime}<br>
			결제영수증 : <a href="${paymentInfoDTO.receiptUrl }">결제영수증url</a><br>
			
		</h3>
		<input type="button" value="확인" onclick="window.close()">

	</body>
</html>