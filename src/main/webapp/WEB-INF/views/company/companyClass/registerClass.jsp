<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 개설 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>

	<section style="max-width: 700px; margin: 50px auto; padding: 30px;">
	    <h2 style="text-align: center; margin-bottom: 20px;">클래스 개설 페이지</h2>
	
<%-- 	    <form action="${pageContext.request.contextPath}/company/myPage/registerClass" method="post"> --%>
		<form action="${pageContext.request.contextPath}/company/myPage/registerClass" method="post" enctype="multipart/form-data">
	        
	        <label><b>강의명</b></label>
	        <input type="text" name="classTitle" required>
	
			<label><b>강의 소개</b></label>
			<textarea name="classIntro" rows="3" required></textarea>
			
			<label><b>강의 상세 내용</b></label>
			<textarea name="classContent" rows="5" required></textarea>
			
	        <label><b>카테고리</b></label>
			<div style="display: flex; gap: 10px; margin-bottom: 15px;">
			  <!-- 대분류 -->
			  <select id="parentCategory" onchange="filterSubCategories()" style="flex:1;">
			    <option value="" disabled selected>대분류</option>
			    <c:forEach var="p" items="${parentCategories}">
			      <option value="${p.categoryIdx}">${p.categoryName}</option>
			    </c:forEach>
			  </select>
			
			  <!-- 소분류 -->
			  <select id="subCategory" name="categoryIdx" required style="flex:1;">
			    <option value="" disabled selected>소분류</option>
			    <c:forEach var="s" items="${subCategories}">
			      <option value="${s.categoryIdx}" data-parent="${s.parentIdx}">
			        ${s.categoryName}
			      </option>
			    </c:forEach>
			  </select>
			</div>
	
			<!-- 커리큘럼 등록 폼 (여러개 입력 가능) -->
			<h3>커리큘럼</h3>
			<div id="curri-area">
			  <div class="curri-item">
			    제목: <input type="text" name="curriculumTitle"><br>
			    시간: <input type="text" name="curriculumRuntime"><br>
			  </div>
			</div>
			
			<button type="button" onclick="addCurriculum()" style="width: 100px;">커리큘럼 추가</button><br><br>
			
	        <label><b>수강료</b></label>
	        <input type="number" name="classPrice" value="0" required>
	
	        <label><b>정원</b></label>
	        <input type="number" name="classMember" required>
	
	        <label><b>강의 시작일</b></label>
	        <input type="date" name="startDate" required>
	
	        <label><b>강의 종료일</b></label>
	        <input type="date" name="endDate" required>
	
	        <label><b>강의 구분</b></label>
			<select name="classType" required>
			  <option value="0">정기 강의</option>
			  <option value="1">단기 강의</option>
			</select>
	        
	        <label><b>수업요일</b></label>
	        <div style="display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 15px;">
	            <label><input type="checkbox" name="classDayNames" value="1">월</label>
	            <label><input type="checkbox" name="classDayNames" value="2">화</label>
	            <label><input type="checkbox" name="classDayNames" value="4">수</label>
	            <label><input type="checkbox" name="classDayNames" value="8">목</label>
	            <label><input type="checkbox" name="classDayNames" value="16">금</label>
	            <label><input type="checkbox" name="classDayNames" value="32">토</label>
	            <label><input type="checkbox" name="classDayNames" value="64">일</label>
	        </div>
	
	        <label><b>장소</b></label>
	        <input type="text" name="location" size="50" required>
	        
			
			<label><b>썸네일 업로드</b></label>
			<input type="file" name="files" multiple accept="image/*">
			
	
	        <div style="text-align: center; margin-top: 30px;">
	            <input type="submit" value="강좌 개설 신청" class="orange-button big-button">
	        </div>
	    </form>
	    
		<script>
		function addCurriculum() {
			const div = document.createElement('div');
			div.classList.add("curri-item");
			div.innerHTML = `
			제목: <input type="text" name="curriculumTitle"><br>
			시간: <input type="text" name="curriculumRuntime"><br><br>
			`;
			document.getElementById("curri-area").appendChild(div);
		}
		</script>
	</section>
	<footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
    </footer>
</body>
</html>