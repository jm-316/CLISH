<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Clish - 이벤트</title>
<link rel="preconnect" href="https://fonts.googleapis.com" >
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="/resources/css/home/top.css" rel="stylesheet" >
<link rel="stylesheet" href="/resources/css/the_best_styles.css" >
<!-- 강의 사이드바 css 활용 -->
<link rel="stylesheet" href="/resources/css/course/sidebar.css">
<link rel="stylesheet" href="/resources/css/event/event_list.css">

<script type="text/javascript" src="/resources/js/home.js"></script>
<link rel='icon' href='/resources/images/logo4-2.png' type='image/x-icon'/>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include> 
	</header>
		<jsp:include page="/WEB-INF/views/event/sidebar.jsp" />
	<main class="main">
		<div class="main-content">
			<div class="table" style="border:1px solid black;width:900px;" >
				<h1>여기 이벤트 썸네일</h1>
			</div>
		</div>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
</body>
</html>