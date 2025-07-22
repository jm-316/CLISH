<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
    <title>기업 정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/join_form.css">
</head>
<body>

<h2>기업 회원정보 수정</h2>

<form action="${pageContext.request.contextPath}/company/myPage/companyInfoSubmit"
      method="post" enctype="multipart/form-data">
    <table border="1" style="width: 100%; text-align: left;">

       	<tr>
			<th>사업자등록번호</th>
			<td>
				<input type="text" name="bizRegNo" value="${company.bizRegNo}">
			</td>
		</tr>
		<tr>
			<th>사업자등록증 업로드</th>
			<td>
				<input type="file" name="bizFile" accept=".jpg,.jpeg,.png,.pdf">
				<button type="button" onclick="confirmBizFileUpload()">[파일 등록]</button>
				<span id="biz-file-result" style="margin-left: 10px; color: green;"></span>
			</td>
		</tr>

		<tr>
			<th>이메일</th>
			<td>
				<div class="email-auth-wrap">
					<input type="email" id="userEmail" name="userEmail" value="${user.userEmail}" required />
					<button type="button" id="emailVerifyBtn">[이메일 인증]</button>
				</div>
<!-- 				<span id="email-auth-result" style="color: red; margin-left: 10px;">이메일 인증 필요</span> -->
					<span id="email-auth-result" style="display: none; color: red;">이메일 인증 필요</span>
			</td>
		</tr>

		<tr>
			<th>회사명</th>
			<td><input type="text" name="userName" id="userName" value="${user.userName}" required></td>
		</tr>

		<tr>
			<th>대표관리자명</th>
			<td><input type="text" name="userRepName" id="userRepName" value="${user.userRepName}" required></td>
		</tr>
		<tr>
			<th>설립일</th>
			<td><input type="date" name="userBirth" id="userBirth" value="${user.userBirth}" required></td>
		</tr>

		<tr>
			<th>아이디</th>
			<td><input type="text" name="userId" id="userId" value="${user.userId}" readonly></td>
		</tr>
	
		<tr>
			<th>새 비밀번호</th>
			<td><input type="password" name="userPassword" id="userPassword"></td>
		</tr>

		<tr>
			<th>새 비밀번호 확인</th>
			<td><input type="password" id="userPasswordConfirm" name="userPasswordConfirm"></td>
		</tr>

		<tr>
			<th>기업전화번호</th>
			<td><input type="text" name="userPhoneNumber" id="userPhoneNumber" value="${user.userPhoneNumber}" required></td>
		</tr>

		<tr>
			<th>대표관리자번호</th>
			<td><input type="text" name="userPhoneNumberSub" id="userPhoneNumberSub" value="${user.userPhoneNumberSub}"></td>
		</tr>

		<tr>
			<th>주소</th>
			<td>
				<input type="text" name="userPostcode" id="userPostcode" placeholder="우편번호" value="${user.userPostcode}" required readonly style="width: 150px;">
				<input type="button" value="주소검색" id="btnSearchAddress"><br>
				<input type="text" name="userAddress1" id="userAddress1" placeholder="기본주소" value="${user.userAddress1}" required readonly style="width: 70%;"><br>
				<input type="text" name="userAddress2" id="userAddress2" placeholder="상세주소" value="${user.userAddress2}" required style="width: 70%;">
			</td>
		</tr>
	</table>

		<input type="hidden" name="userType" value="${sessionScope.userType}" />
		<input type="hidden" name="userIdx" value="${user.userIdx}" />
		<p>
			<button type="submit" >수정하기</button>
		
		</p>
	</form>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="module">
		import { initEmailAuth } from '/resources/js/email/email_auth.js';
		import { initJoinForm } from '/resources/js/user/join_form.js';

		window.addEventListener("DOMContentLoaded", () => {
			initJoinForm();
			initEmailAuth("userEmail", "emailVerifyBtn", "email-auth-result", { lockOnSuccess: true });
		});
	</script>
</body>
</html>