<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	
		<h1>${sessionScope.sId} 정보변경</h1>
		
		<hr>
		
		<form action="/myPage/change_user_info" method="post" class="form" name="modifyForm">
			<table border="1" style="width: 100%; text-align: left;">	
			<!-- 공통 입력 영역 -->
			<tr>
				<th>이메일</th>
				<td>
					<input type="email" id="userEmail" name="userEmail" value="${user.userEmail }" readonly/>
					
					<input type="button" id="changeEmail" name="changeEmail" value="이메일변경" onclick="changeEmail()"/>
					<button type="button" id="emailVerifyBtn" style="display: none;">[이메일 인증]</button>
					<span id="email-auth-result" style="display: none; color: red; margin-left: 10px;">이메일 인증 필요</span>
				</td>
			</tr>
			<tr>
				<th><label for="userName">회원이름</label></th>
				<td><input type="text" name="userName" id="userName" value="${user.userName }"></td>
			</tr>
	
			<tr>
				<th><label for="userRepName"><c:if test="${sessionScope.userType == 1}">닉네임</c:if><c:if test="${sessionScope.userType == 2}">대표관리자명</c:if></label></th>
				<td>
					<input type="text" name="userRepName" id="userRepName" value="${user.userRepName }">
					<input type="button" id="checkNickname" value="중복확인">
				</td>
			</tr>
	
			<tr>
				<th><label for="userBirth">생년월일</label></th>
				<td><input type="date" name="userBirth" id="userBirth" value="${user.userBirth }"></td>
			</tr>
	
			<c:if test="${sessionScope.userType == 1}">
				<tr>
					<th><label for="userGender">성별</label></th>
					<td>
						<select name="userGender" id="userGender" required>
							<option value="">선택</option>
							<option value="M" <c:if test="${user.userGender eq 'M' }">selected</c:if>>남자</option>
							
							<option value="F" <c:if test="${user.userGender eq 'F' }">selected</c:if>>여자</option>
						</select>
					</td>
				</tr>
			</c:if>
	
			<tr>
				<th><label for="userId">아이디</label></th>
				<td><input type="text" name="userId" id="userId" value="${user.userId }" readonly="readonly"></td>
			</tr>
	
			<tr>
			    <th><label for="userPassword">새 비밀번호</label></th>
			    <td>
			    	<input type="password" name="newPassword" id="userPassword" >
			   		<div id="checkPasswdResult" style="margin-top: 5px;"></div>
			    </td>
			</tr>

			<tr>
			    <th><label for="userPasswordConfirm">새 비밀번호 확인</label></th>
			    <td>
			        <input type="password" id="userPasswordConfirm" name="newPasswordConfirm" >
			        <span id="pw-match-msg" style="margin-left: 10px;"></span>
			        <div id="checkPasswd2Result" style="margin-top: 5px;"></div>
			    </td>
			</tr>
			
			<tr>
				<th><label for="userPhoneNumber"><c:if test="${sessionScope.userType == 1}">휴대폰번호</c:if><c:if test="${sessionScope.userType == 2}">기업전화번호</c:if></label></th>
				<td><input type="text" name="userPhoneNumber" id="userPhoneNumber" value="${user.userPhoneNumber }" required></td>
			</tr>
	
			<tr>
				<th><label for="userPhoneNumberSub"><c:if test="${sessionScope.userType == 1}">비상연락망</c:if><c:if test="${sessionScope.userType == 2}">대표관리자번호</c:if></label></th>
				<td><input type="text" name="userPhoneNumberSub" id="userPhoneNumberSub" value="${user.userPhoneNumberSub }"></td>
			</tr>
	
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="userPostcode" id="userPostcode" placeholder="우편번호" required readonly style="width: 150px;" value=${user.userPostcode }>
					<input type="button" value="주소검색" id="btnSearchAddress"><br>
					<input type="text" name="userAddress1" id="userAddress1" placeholder="기본주소" required readonly style="width: 70%;" value=${user.userAddress1 }><br>
					<input type="text" name="userAddress2" id="userAddress2" placeholder="상세주소" required style="width: 70%;" value=${user.userAddress2 }>
				</td>
			</tr>
		</table>
		<input type="hidden" name="userType" value="${sessionScope.userType}"/>
		<p><button type="submit">정보변경</button></p>
		</form>
	
	</div>
	
	</main>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="module">
	import { initEmailAuth } from '/resources/js/email/email_auth.js';
	import { initJoinForm } from '/resources/js/user/join_form.js';

	window.addEventListener("DOMContentLoaded", () => {
		initJoinForm();
		initEmailAuth("userEmail", "emailVerifyBtn", "email-auth-result");
	});
</script>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
	    const emailInput = document.getElementById("userEmail");
	    const changeBtn = document.getElementById("changeEmail");
	    const verifyBtn = document.getElementById("emailVerifyBtn");
	    const authResult = document.getElementById("email-auth-result");
	
	    changeBtn.addEventListener("click", function() {
	        // 이메일 입력창 수정 가능
	        emailInput.removeAttribute("readonly");
	        emailInput.focus();
	
	        // 이메일 인증 버튼, 인증 안내 문구 모두 보이게
	        verifyBtn.style.display = "inline-block";
	        authResult.style.display = "inline-block";
	
	        // "이메일변경" 버튼 숨김 (또는 비활성화 해도 됨)
	        changeBtn.style.display = "none";
    });
});
</script>
