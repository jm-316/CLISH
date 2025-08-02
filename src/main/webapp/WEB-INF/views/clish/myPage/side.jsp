<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="/resources/css/myPage.css" rel="stylesheet">
  

<div id="side">
	<div class="title-fixed">
		<h1><a href="/myPage/main">${sessionScope.sId}'s page</a></h1>
	</div>
	<input type="button" value="개인정보변경" class="slide_btn" onclick="location.href='/myPage/change_user_info'"><br>
<!-- 	<input type="button" value="즐겨찾기" class="slide_btn" onclick="location.href='/myPage/favoriteClass'"><br> -->
	<input type="button" value="결제내역" class="slide_btn" onclick="location.href='/myPage/payment_info'"><br>
	<input type="button" value="나의문의" class="slide_btn" onclick="location.href='/myPage/myQuestion'"><br>
	<input type="button" value="후기관리" class="slide_btn" onclick="location.href='/myPage/myReview'"><br>
	<input type="button" value="알림전체보기" class="slide_btn" onclick="location.href='/myPage/notification'"><br>
	<input type="button" value="회원탈퇴" class="slide_btn" onclick="location.href='/myPage/withdraw'"><br>
</div>

