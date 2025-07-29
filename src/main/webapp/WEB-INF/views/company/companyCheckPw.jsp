<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기업 정보 수정 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
	<style type="text/css">
		/* 큰 전체 박스 */
		.main-container {
		    display: flex;
		    width: 100%;
		    min-height: 600px; /* 필요에 따라 조절 */
		}
		
		/* 왼쪽 사이드바 */
		.sidebar {
		    width: 200px; /* 필요에 따라 조절 */
		    background-color: #f8f8f8;
		    padding: 20px;
		}
		
		/* 오른쪽 본문 */
		.content-area {
		    flex: 1;
		    padding: 40px;
		    background-color: #ffffff;
		}
	</style>
</head>
<body>

    <!-- 공통 헤더 -->
    <header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<!-- ✅ 메인 콘텐츠 전체를 감싸는 큰 flex 박스 -->
    <div class="main-container">
    	 <!-- 왼쪽 사이드바 -->
        <div class="sidebar">
            <jsp:include page="/WEB-INF/views/company/comSidebar.jsp" />
        </div>
        
	<!-- 오른쪽 본문 영역 -->
	<div class="content-area">
		<div class="class-header">
			<h1>${sessionScope.sId} 페이지</h1>
		</div>
		
		<form action="${pageContext.request.contextPath}/company/myPage/companyInfo" method="post" class="form">
		    <h3>비밀번호를 입력하세요</h3><br>
		    <input type="password" name="userPassword" placeholder="pw" required>
		    <input type="submit" value="확인">			
		</form>
	</div>
    </div>
    
    <!-- 공통 푸터 -->
    <footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
    </footer>

</body>
</html>