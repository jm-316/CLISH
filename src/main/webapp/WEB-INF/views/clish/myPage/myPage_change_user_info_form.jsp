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
				<td><input type="text" name="userName" id="userName" readonly value="${user.userName }"></td>
			</tr>
	
			<tr>
				<th><label for="userRepName">닉네임</label></th>
				<td>
					<input type="text" name="userRepName" id="userRepName" value="${user.userRepName }">
					<span id="checkRepNameResult"></span>
<!-- 					<input type="button" value="중복확인" id="checkRepName" -->
<%-- 						onclick="repNameCheck(document.getElementById('userRepName').value,'${user.userIdx }')"> --%>
				</td>
			</tr>
	
			<tr>
				<th><label for="userBirth">생년월일</label></th>
				<td><input type="date" name="userBirth" id="userBirth" value="${user.userBirth }"></td>
				<span id="birthCheckResult"></span>
			</tr>
	
			<c:if test="${sessionScope.sUT == 1}">
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
				<th><label for="userPhoneNumber">휴대폰번호</label></th>
				<td>
				<input type="text" name="userPhoneNumber" id="userPhoneNumber" value="${user.userPhoneNumber }" required>
				<span id="phoneCheckResult"></span>
				</td>
			</tr>
	
			<tr>
				<th><label for="userPhoneNumberSub"><c:if test="${sessionScope.sUT == 1}">비상연락망</c:if><c:if test="${sessionScope.userType == 2}">대표관리자번호</c:if></label></th>
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
		<input type="hidden" name="userType" value="${sessionScope.sUT}"/>
		<p><button type="submit" id="submitBtn"> 정보변경</button></p>
		</form>
	
	</div>
	
	</main>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="module">
	import { initEmailAuth } from '/resources/js/email/email_auth.js';
	initEmailAuth("userEmail", "emailVerifyBtn", "email-auth-result");
</script>
<script type="text/javascript">
	window.isEmailVerified = true;
	
	document.addEventListener("DOMContentLoaded", function() {
	    const emailInput = document.getElementById("userEmail");
	    const changeBtn = document.getElementById("changeEmail");
	    const verifyBtn = document.getElementById("emailVerifyBtn");
	    const authResult = document.getElementById("email-auth-result");
		const userRepNameInput = document.getElementById('userRepName');
		const initialRepName = userRepNameInput.value.trim();
		const userIdx = '${user.userIdx}';
		const pwInput = document.getElementById("userPassword");
		const pwConf = document.getElementById("userPasswordConfirm");
		const phoneInput = document.getElementById("userPhoneNumber");
		const submitBtn = document.getElementById("submitBtn");
		const addressBtn = document.getElementById("btnSearchAddress");
		const postcodeInput = document.getElementById("userPostcode");
		const address1Input = document.getElementById("userAddress1");
		const address2Input = document.getElementById("userAddress2");

		var isPwOk = true;
		var isPwMatchOk = true;
		var isRepNameOk = true;
		var isPhoneOk = true;
		var isAddressOk = true;
		
		updateSubmitButton();
		
	    changeBtn.addEventListener("click", function() {
	    	window.isEmailVerified = false;
	    	// 이메일 입력창 수정 가능
	        emailInput.removeAttribute("readonly");
	        emailInput.focus();
	
	        // 이메일 인증 버튼, 인증 안내 문구 모두 보이게
	        verifyBtn.style.display = "inline-block";
	        authResult.style.display = "inline-block";
	
	        // "이메일변경" 버튼 숨김 (또는 비활성화 해도 됨)
	        changeBtn.style.display = "none";
	    });
	    
		// 닉네임창 벗어나면 중복체크 실행
		userRepNameInput.addEventListener('blur', () => {
		    let currentRepName = userRepNameInput.value.trim();
		    if (currentRepName.length > 0) {
		    	isRepNameOk = false;
		        repNameCheck(currentRepName, userIdx);
		    } else {
		        document.getElementById('checkRepNameResult').innerText = '';
		    }
		});
		
		// 닉네임 중복체크 함수
		function repNameCheck(userRepName, userIdx) { //사용중인 닉네임 체크 하기위해 userIdx, 입력된 userRepName 추가
			$.ajax({
				type: "GET",
				url: "/myPage/check/repName",
				data: {
					userIdx: userIdx,
					userRepName: userRepName
				},
				dataType: "json"
			}).done(function(response) {
				const msg = response.msg || '처리 완료'; // 없으면 기본 메시지
				$("#checkRepNameResult").html(msg);
				if(response.status == 'fail'){
					isRepNameOk = false; //사용불가
				} else {
					userRepNameInput.value = response.repName;
					isRepNameOk = true; // 사용가능
				}
					updateSubmitButton();
			}).fail(function(response){
				alert("잠시후 다시 시도하세요");	
				isRepNameOk = false;
				updateSubmitButton();
			})
		}
		
		// 새비밀번호 입력창 벗어날시 실행
		if(pwInput) {
			pwInput.onblur = function () {
				const pwd = this.value;
				const result = document.getElementById("checkPasswdResult");
				
				if(pwd.length > 0 ){	// 새비밀번호에 입력값이 있을때			
					const pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%])[A-Za-z\d!@#$%]{8,16}$/;
					if(!pattern.test(pwd)) { // 패턴불일치
						result.innerText = "영문자, 숫자, 특수문자(!@#$%) 조합 8 ~ 16글자 필수!";
						result.style.color = "red";
						isPwOk = false; // 정보수정 불가
					} else{ // 패턴일치
						result.innerText = pwd.length >= 12 ? "안전" : (pwd.length >= 10 ? "보통" : "위험");
						result.style.color = pwd.length >= 12 ? "green" : (pwd.length >= 10 ? "orange" : "red");
						isPwOk = true; // 정보수정 가능
					}
				} else { // 입력값이 없을떄 
					isPwOk = true; // 정보수정 가능
					result.innerText = "";
				}
				updateSubmitButton(); // 유효성검사
			};
		}
	
		// 5. 비밀번호2 1과의 동일한 값 확인
		if(pwInput && pwConf) { 
			pwConf.onblur = function () { //새 비밀번호 확인창에서 벗어날때 실행
				const pwd = pwInput.value;
				const pwd2 = this.value;
				const result = document.getElementById("checkPasswd2Result");
				if(pwd.length > 0 || pwd2.length > 0){ // 둘중 하나라도 입력값이 존재한다면
					if(pwd === pwd2) {
						result.innerText = "비밀번호 확인 완료!";
						result.style.color = "green";
						isPwMatchOk = true; // 정보수정 가능
					} else{
						result.innerText = "비밀번호 다름!";
						result.style.color = "red";
						isPwMatchOk = false; // 정보수정 불가
					}
				} else {
					isPwMatchOk = true;  
					result.innerText = "";
				}
				updateSubmitButton();
			};
		}
		
		
		// 6. 전화번호 중복 & 정규표현식 체크
		phoneInput.addEventListener('blur', function() {
		    const phone = this.value.replace(/\s+/g, "");
		    const resultSpan = document.getElementById('phoneCheckResult');
		    const pattern = /^\d{3}-\d{4}-\d{4}$/;
		    const currentUserPhoneNumber = phoneInput.value.trim();
		    // 1차: 정규표현식 체크
		    if (!pattern.test(phone)) {
		        resultSpan.innerText = '전화번호 형식은 ***-****-**** 입니다.';
		        resultSpan.style.color = 'red';
		        isPhoneOk = false;
		        updateSubmitButton();
		        return;
		    } else {
		    	resultSpan.innerText = '';
		    }
		
		    // 2차: 서버에 중복체크 요청
			$.ajax({
				type: "GET",
				url: "/myPage/check/userPhoneNumber",
				data: {
					userIdx: userIdx,
					userPhoneNumber: currentUserPhoneNumber
				},
				dataType: "json" // 응답 데이터를 무조건 JSON 객체로 취급(= 실제 데이터 타입 자동 판별)
			}).done(function(response) {
				// 버튼 클릭할 때마다 테이블 새로 생성
				const msg = response.msg || '처리 완료'; // 없으면 기본 메시지
				$("#phoneCheckResult").html(msg);
				if(response.status == 'fail'){
					isPhoneOk = false;
				} else {
					isPhoneOk = true;
				}
			}).fail(function(response){
				alert("잠시후 다시 시도하세요");	
			})
			updateSubmitButton();
		});
		
		// 7. 주소 검색 API
		if(addressBtn) {
		    addressBtn.onclick = function () {
		        new daum.Postcode({
		            oncomplete: function (data) {
		                const address = data.buildingName
		                    ? data.address + " (" + ${data.buildingName} + ")"
		                    : data.address;
		                postcodeInput.value = data.zonecode;
		                address1Input.value = address;
		                address2Input.focus();
		                checkAddressFields();
		            }
		        }).open();
		    };
		}
		
		function checkAddressFields() {
		    if (
		        postcodeInput.value.trim() &&
		        address1Input.value.trim() &&
		        address2Input.value.trim()
		    ) {
		        isAddressOk = true;
		    } else {
		        isAddressOk = false;
		    }
		    updateSubmitButton();
		}
		
		[postcodeInput, address1Input, address2Input].forEach(input => {
		    input.addEventListener('input', checkAddressFields);
		});
		
		
		function updateSubmitButton() {
			 console.log({
				isRepNameOk,
		        isPwOk,
		        isPwMatchOk,
		        isPhoneOk,
		        isEmailVerified: window.isEmailVerified
		    });
		    if(isRepNameOk && isPwOk && isPwMatchOk &&  isPhoneOk && window.isEmailVerified) {
		        submitBtn.disabled = false;
		    } else{
		        submitBtn.disabled = true;
		    }
		}
	});
</script>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>
