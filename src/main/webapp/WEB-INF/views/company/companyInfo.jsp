<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기업 정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/join_form.css">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
<style>
	#footer-area {
      margin-top: 0 !important;
    }
	
    /* ✅ 사이드바와 본문 묶는 container 전체 높이 조정 */
    .container {
        display: flex;
        min-height: calc(100vh - 100px); /* 푸터 높이만큼 뺀 높이로 화면 채움 */
    }

    /* 왼쪽 사이드바 */
	.sidebar {
	    width: 220px;
	    background-color: #f5f5f5;
	    padding: 30px 20px;
	    box-sizing: border-box;
	    border-right: 1px solid #ddd;
	    overflow: hidden;          /* ✅ 내부 넘치는 거 잘라냄 */
	    white-space: nowrap;       /* ✅ 줄넘김 방지 */
	}
	
	.sidebar h2 {
        display: block;
	    text-align: left;
	    margin-left: 0px;
	    padding-left: 0px;
	    font-weight: bold;
    }

    /* ✅ 메인 콘텐츠 스타일 - 폼을 화면 위쪽으로 */
    .main-content {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: flex-start; /* 중앙보다 위 정렬 */
        padding: 40px 0;
    }

    /* ✅ form-wrapper 위치 위로 이동 + 그림자 추가 */
    .form-wrapper {
        max-width: 1000px;
        margin-top: 40px; /* 중앙보다 위로 */
        margin-right: 200px;
        padding: 20px;
        background: #fff;
        box-shadow: 0 0 8px rgba(0,0,0,0.1);
    }

    /* 테이블 기본 스타일 */
    .form-wrapper table {
        width: 100%;
        border-collapse: collapse;
        margin: 80px;
    }

    .form-wrapper th, .form-wrapper td {
        padding: 10px;
        vertical-align: top;
    }

    .form-wrapper th {
        width: 180px;
        text-align: left;
        background-color: #f4f4f4;
    }

    /* 버튼 가운데 정렬 */
    .form-wrapper p {
        text-align: center;
        margin-top: 30px;
    }

    /* 주소 input 스타일 제한 */
    #userPostcode {
        width: 150px;
    }

    #userAddress1,
    #userAddress2 {
        width: calc(100% - 20px);
    }

    /* 이메일 인증 input + 버튼 가로 정렬 */
    .email-auth-wrap input {
        width: 60%;
        vertical-align: middle;
    }

    .email-auth-wrap button {
        vertical-align: middle;
        margin-left: 10px;
    }

    /* 파일 등록 버튼 옆 정렬 */
    td:has(input[type="file"]) {
        white-space: nowrap;
    }

    input[type="file"] {
        vertical-align: middle;
    }

</style>
</head>
<body>
	
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<!-- ✅ 사이드바 + 본문을 묶는 container 시작 -->
	<div class="container">
		<!-- 사이드바 -->
		<div class="sidebar">
			<jsp:include page="/WEB-INF/views/company/comSidebar.jsp" />
		</div>
	
		<!-- ✅ 메인 콘텐츠 -->
		<div class="main-content">
			<div class="form-wrapper">
			<h2 style="text-align:center;">${sessionScope.sId} 기업 회원정보 수정</h2>
			<form action="${pageContext.request.contextPath}/company/myPage/companyInfoSubmit"
			      method="post" enctype="multipart/form-data">
			    <table border="1" style="width: 80%;">
			
			       	<tr>
						<th>사업자등록번호</th>
						<td>
							<input type="text" name="bizRegNo" value="${company.bizRegNo}">
						</td>
					</tr>
					<tr>
						<th>사업자등록증 업로드</th>
						<td>
					        <input type="file" name="files" accept=".jpg,.jpeg,.png,.pdf">
					        <span id="biz-file-result" style="margin-left: 10px; color: green;"><br>
					            <c:if test="${not empty company.bizFileName}">
					                현재 등록된 파일: ${company.bizFileName}
					            </c:if>
					        </span>
					    </td>
					</tr>
			
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
						<td>
							<input type="text" id="userPhoneNumber" name="userPhoneNumber" value="${user.userPhoneNumber}" required>
							<span id="phoneCheckResult"></span>
						</td>
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
			
					<input type="hidden" name="userType" value="${empty sessionScope.userType ? 2 : sessionScope.userType}" />
					<input type="hidden" name="userIdx" value="${user.userIdx}" />
					<p>
						<button type="submit" >수정하기</button>
					</p>
				</form>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="module">
		import { initEmailAuth } from '/resources/js/email/email_auth.js';
		initEmailAuth("userEmail", "emailVerifyBtn", "email-auth-result");
	</script>
	
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
		  
			 // 주소 검색 버튼 이벤트 바인딩
		    document.getElementById("btnSearchAddress").addEventListener("click", function () {
	        new daum.Postcode({
	            oncomplete: function (data) {
	                let addr = '';
	                if (data.userSelectedType === 'R') {
	                    addr = data.roadAddress;
	                } else {
	                    addr = data.jibunAddress;
	                }

	                document.getElementById("userPostcode").value = data.zonecode;
	                document.getElementById("userAddress1").value = addr;
	                document.getElementById("userAddress2").focus();
	            }
	        }).open();
	    });
	});	    
	</script>
	
	<c:if test="${modifySuccess == true}">
    <script>
	        alert("기업 정보 수정이 완료되었습니다.");
	    </script>
	</c:if>
	<c:if test="${modifySuccess == false}">
	    <script>
	        alert("기업 정보 수정에 실패했습니다.");
	    </script>
	</c:if>
	
	<footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
    </footer>
</body>
</html>