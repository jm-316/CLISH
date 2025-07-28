<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 수정 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	<main>
		<section style="max-width: 800px; margin: 50px auto; padding: 40px;">
			<h1>클래스 수정 페이지</h1>
			<h3 style="text-align: center; margin-bottom: 30px;">[ 클래스 정보 수정 ]</h3>

			 <form action="/company/myPage/modifyClass" method="post">
			<table class="table-with-side-borders" style="width: 90%;">
				<input type="hidden" name="classIdx" value="${classInfo.classIdx}" />
				<input type="hidden" name="userIdx" value="${classInfo.userIdx}">
				<tr>
					<th>강의명</th>
					<td><input type="text" name="classTitle" value="${classInfo.classTitle}"></td>
				</tr>
				<tr>
				  <th>카테고리</th>
				  <td>
				    <!-- 대분류 -->
				    <select id="parentCategory" onchange="filterSubCategories()" style="margin-right: 10px;">
				      <c:forEach var="p" items="${parentCategories}">
				        <option value="${p.categoryIdx}"
				          <c:if test="${fn:startsWith(classInfo.categoryIdx, p.categoryIdx)}">selected</c:if>>
				          ${p.categoryName}
				        </option>
				      </c:forEach>
				    </select>
				
				    <!-- 소분류 -->
				    <select id="subCategory" name="categoryIdx">
				      <c:forEach var="s" items="${subCategories}">
				        <option value="${s.categoryIdx}" data-parent="${s.parentIdx}"
				          <c:if test="${classInfo.categoryIdx eq s.categoryIdx}">selected</c:if>>
				          ${s.categoryName}
				        </option>
				      </c:forEach>
				    </select>
				  </td>
				</tr>
				<tr>
					<th>상태</th>
					<td>
					<select name="classStatus" required>
			            <option value="1" ${classInfo.classStatus == 1 ? "selected" : ""}>임시저장</option>
			            <option value="2" ${classInfo.classStatus == 2 ? "selected" : ""}>공개</option>
			            <option value="3" ${classInfo.classStatus == 3 ? "selected" : ""}>마감</option>
		            </td>
		        </select><br>
		        </tr>
		        <tr>
					<th>수강료</th>
					<td><input type="number" name="classPrice" value="${classInfo.classPrice}"></td>
				</tr>
				<tr>
					<th>정원</th>
					<td><input type="number" name="classMember" value="${classInfo.classMember}"></td>
				</tr>
				<tr>
					<th>강의 기간</th>
					<td>
						<input type="date" name="startDate" value="${classInfo.startDate}">
						~ <input type="date" name="endDate" value="${classInfo.endDate}">
					</td>
				</tr>
				<tr>
					<th>수업 요일</th>
					<td>
						<label><input type="checkbox" class="day" name="class_days" value="1">월</label>
						<label><input type="checkbox" class="day" name="class_days" value="2">화</label>
						<label><input type="checkbox" class="day" name="class_days" value="4">수</label>
						<label><input type="checkbox" class="day" name="class_days" value="8">목</label>
						<label><input type="checkbox" class="day" name="class_days" value="16">금</label>
						<label><input type="checkbox" class="day" name="class_days" value="32">토</label>
						<label><input type="checkbox" class="day" name="class_days" value="64">일</label>
						<input type="hidden" name="classDays" id="classDays" value="${classInfo.classDays}" />
					</td>
				</tr>
				<tr>
					<th>장소</th>
					<td><input type="text" name="location" value="${classInfo.location}"></td>
				</tr>
				<tr>
					<th>강의 소개</th>
					<td><textarea name="classIntro">${classInfo.classIntro}</textarea></td>
				</tr>
				<tr>
					<th>강의 상세 내용</th>
					<td><textarea name="classContent">${classInfo.classContent}</textarea></td>
				</tr>
				<tr>
					<th>썸네일 이미지 경로</th>
					<td><img src="${pageContext.request.contextPath}/resources/upload/${classInfo.classPic1}" width="200"></td>
				</tr>
			</table>

			<h3>📚 커리큘럼 수정</h3>
<%-- 			<c:forEach var="curri" items="${curriculumList}"> --%>
<%-- 				<input type="hidden" name="curriculumIdx" value="${curri.curriculumIdx}" /> --%>
<!-- 				<p> -->
<%-- 					<b>제목:</b> <input type="text" name="curriculumTitle" value="${curri.curriculumTitle}"> --%>
<%-- 					<b>시간:</b> <input type="text" name="curriculumRuntime" value="${curri.curriculumRuntime}"> --%>
<!-- 				</p> -->
<%-- 			</c:forEach> --%>

<!-- 			<div style="display: flex; justify-content: center; margin-top: 40px;"> -->
<!-- 				<button type="submit" class="orange-button">수정 완료</button> -->
<!-- 			</div> -->
			<!-- ================================================================================================= -->
			<!-- 기존 커리큘럼을 출력하는 영역 (처음에 보여지는 것들) -->
			<<div id="curriculumContainer">
				<c:forEach var="curri" items="${curriculumList}">
					<div class="curriculum-box">
						<input type="hidden" name="curriculumIdx" value="${curri.curriculumIdx}" />
						<b>제목:</b> <input type="text" name="curriculumTitle" value="${curri.curriculumTitle}">
						<b>시간:</b> <input type="text" name="curriculumRuntime" value="${curri.curriculumRuntime}">
						<!-- 삭제 버튼 추가 (기존 커리큘럼도 지울 수 있게) -->
						<button type="button" onclick="removeCurriculum(this)">삭제</button>
					</div>
				</c:forEach>
			</div>
			
			<!-- 새 커리큘럼을 추가할 때 사용할 빈 템플릿 (처음엔 숨김) -->
			<div id="curriculumTemplate" style="display: none;">
				<div class="curriculum-box">
					<input type="hidden" name="curriculumIdx" value="0" />
					<b>제목:</b> <input type="text" name="curriculumTitle" placeholder="제목 입력">
					<b>시간:</b> <input type="text" name="curriculumRuntime" placeholder="시간 입력">
					<button type="button" onclick="removeCurriculum(this)">삭제</button>
				</div>
			</div>

			<!-- 커리큘럼 추가 버튼 -->
			<div style="margin-top: 10px;">
				<button type="button" onclick="addCurriculum()">커리큘럼 추가</button>
			</div>

			<!-- 제출 버튼 -->
			<div style="display: flex; justify-content: center; margin-top: 40px;">
				<button type="submit" class="orange-button">수정 완료</button>
			</div>
			</form>
		</section>
	</main>
	<footer>
        <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
    </footer>

	<!-- ✅ 요일 처리 스크립트 -->
	<script>
	window.addEventListener("DOMContentLoaded", function () {
	    const value = parseInt(document.getElementById("classDays").value || "0");
	    document.querySelectorAll(".day").forEach(cb => {
	        if (value & parseInt(cb.value)) {
	            cb.checked = true;
	        }
	    });
	});	
	document.querySelector("form").addEventListener("submit", function () {
	    let total = 0;
	    document.querySelectorAll(".day:checked").forEach(cb => {
	        total += parseInt(cb.value);
	    });
	    document.getElementById("classDays").value = total;
	});
	</script>

	<script>
		// ✅ 커리큘럼 추가 함수
		function addCurriculum() {
			const container = document.getElementById("curriculumContainer");
			const template = document.getElementById("curriculumTemplate").innerHTML;
			container.insertAdjacentHTML("beforeend", template);
		}
	
		// ✅ 커리큘럼 삭제 함수
		function removeCurriculum(button) {
			const box = button.parentElement;
			box.remove();
		}
	</script>

</body>
</html>