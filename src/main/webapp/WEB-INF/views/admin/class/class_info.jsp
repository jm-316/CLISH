<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/resources/css/admin/modal.css"
	rel="stylesheet" type="text/css">
</head>
<style>
</style>
<body>
	<div class="container">
		<div class="sidebar">
			<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"></jsp:include>
		</div>
		<div class="modal">
			<div class="modal_body">
				<h3>강좌 반려</h3>
				<form action="/admin/class/${classInfo.classIdx}/reject"
					method="post">
					<div>
						<label>강좌명</label> <input type="text"
							value="${classInfo.classTitle}" readonly />
					</div>
					<div>
						<label>반려사유</label>
						<textarea rows="10" cols="20" name="content"></textarea>
					</div>
					<button type="button" onclick="closeModal()">닫기</button>
					<button type="submit">반려하기</button>
				</form>
			</div>
		</div>
		<div class="main">
			<jsp:include page="/WEB-INF/views/admin/header.jsp"></jsp:include>
			<div class="main_container">
				<div class="bg-light">
					<div>
						<h3 class="section-title">강좌 수정</h3>
					</div>
					<form id="classForm" style="border: none; padding: 10px;" enctype="multipart/form-data">
						<input type="hidden" name="userIdx" id="userIdx" value="${classInfo.userIdx}" />
						<div>
							<div style="display: flex; flex: 1 1 auto;  align-items: center; justify-content: space-between; margin-left: 30px; margin-right: 30px">
								<div style="display: flex; flex-direction: column;">
									<div style="width: 950px;">
										<label>강의명</label> 
										<input type="text" value="${classInfo.classTitle}" name="classTitle" id="classTitle" />
									</div>
									<div>
										<span>강의 소개</span>
										<textarea name="classIntro" id="classIntro">${classInfo.classIntro}</textarea>
									</div>
									<div>
										<span>강의 상세 내용</span>
										<textarea rows="9" cols="10" name="classContent" id="classContent">${classInfo.classContent}</textarea>
									</div>
								</div>
								<div style="width: 350px; height: 350px; display: flex; flex-direction: column; align-items: center; gap: 30px;">
									<c:forEach var="fileDTO" items="${classInfo.fileList}">
										<img src="/resources/upload/${fileDTO.subDir}/${fileDTO.realFileName}" width="300px" height="300px"/>
										<div>
											${fileDTO.originalFileName}
											<a href="/resources/upload/${fileDTO.subDir}/${fileDTO.realFileName}" download="${fileDTO.originalFileName}">
												<img src="/resources/images/download-icon.png" class="img_btn" title="다운로드" />
											</a>
					
											<a href="javascript:deleteFile(${fileDTO.fileId})">
												<img src="/resources/images/delete-icon.png" class="img_btn" title="삭제" />
											</a>
										</div>
									</c:forEach>
									<c:if test="${empty classInfo.fileList}">
										<input type="file"  name="files" multiple>
									</c:if>
								</div>
							</div>
						</div>
						<div style="display: flex; align-items: center; justify-content: flex-start; gap: 30px; margin-left: 30px; ">
							<div style="width: 300px;">
								<label for="startDate">시작날짜</label> 
								<input type="date" value="${classInfo.startDate}" name="startDate" id="startDate" />
							</div>
							<div style="width: 300px;">
								<label for="endDate">종료날짜</label> 
								<input type="date" value="${classInfo.endDate}" name="endDate" id="endDate" />
							</div>
							<c:if test="${classInfo.classStatus != 1}">
								<div style="width: 300px;">
									<label for="classStatus">공개상태</label> 
									<select name="classStatus" id="classStatus">
										<option value="2"
											<c:if test="${classInfo.classStatus == 2}">selected</c:if>>오픈</option>
										<option value="3"
											<c:if test="${classInfo.classStatus == 3}">selected</c:if>>마감</option>
									</select>
								</div>
							</c:if>
						</div>
						<div style="display: flex; align-items: center; justify-content: flex-start; gap: 30px; margin-left: 30px; ">
							<div style="width: 300px;">
								<label for="classType">강의 타입</label>
								<select id="classType">
									<option <c:if test="${classInfo.classType eq 0 }">selected</c:if> value="0">장기</option>
									<option <c:if test="${classInfo.classType eq 1 }">selected</c:if> value="1">단기</option>
								</select>
							</div>
							<div style="width: 300px;">
								<label>정원</label> 
								<input type="number" value="${classInfo.classMember}" name="classMember" id="classMember" />
							</div>
							<div style="width: 300px;">
								<label>가격</label>
								<fmt:formatNumber value="${classInfo.classPrice}" type="number" maxFractionDigits="0" var="formattedPrice" />
								<input type="number" value="${classInfo.classPrice.intValue()}" name="classPrice" id="classPrice" />
							</div>
						</div>
						<div style="display: flex; flex-direction: column;  margin-left: 30px; margin-bottom: 10px;">
							<label >수업요일</label> 
							<div>
								<input type="checkbox" class="day-checkbox" value="1"
									<c:if test="${fn:contains(classInfo.classDayNames, '월')}">checked</c:if> />월
								<input type="checkbox" class="day-checkbox" value="2"
									<c:if test="${fn:contains(classInfo.classDayNames, '화')}">checked</c:if> />화
								<input type="checkbox" class="day-checkbox" value="4"
									<c:if test="${fn:contains(classInfo.classDayNames, '수')}">checked</c:if> />수
								<input type="checkbox" class="day-checkbox" value="8"
									<c:if test="${fn:contains(classInfo.classDayNames, '목')}">checked</c:if> />목
								<input type="checkbox" class="day-checkbox" value="16"
									<c:if test="${fn:contains(classInfo.classDayNames, '금')}">checked</c:if> />금
								<input type="checkbox" class="day-checkbox" value="32"
									<c:if test="${fn:contains(classInfo.classDayNames, '토')}">checked</c:if> />토
								<input type="checkbox" class="day-checkbox" value="64"
									<c:if test="${fn:contains(classInfo.classDayNames, '일')}">checked</c:if> />일
								<input type="hidden" name="classDays" id="classDays" />
							</div>
						</div>
						<div style="margin-left: 30px; margin-right: 30px; width: 950px">
							<label for="location">수업장소</label> 
							<input type="text" value="${classInfo.location}" name="location" id="location" />
						</div>
						<div style="margin-left: 30px;">
							<span>카테고리</span>
							<div style="display: flex; align-items: center; gap: 30px;">
								<div style="width: 300px;">
									<div>대분류</div>
									<select>
										<c:forEach var="category" items="${parentCategories}">
											<option value="${category.categoryIdx}"
												<c:if test="${selectedParentCategory != null && category.categoryIdx == selectedParentCategory.categoryIdx}">selected</c:if>>
												${category.categoryName}</option>
										</c:forEach>
									</select>
								</div>
								<div style="width: 300px;">
									<div>소분류</div>
									<select name="categoryIdx">
										<c:forEach var="category" items="${childCategories}">
											<option value="${category.categoryIdx}"
												<c:if test="${selectedChildCategory != null && category.categoryIdx == selectedChildCategory.categoryIdx}">selected</c:if>>
												${category.categoryName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div style="margin-left: 30px; margin-right: 30px;">
							<div style="display: flex; align-items: center; justify-content: space-between;">
								<h3>📚 커리큘럼 소개</h3>
								<button type="button" onclick="addCurriculum()">커리큘럼 추가</button>
							</div>
							<div id="curriculumContainer">
								<c:forEach var="curri" items="${curriculumList}">
									<div class="curriculum-box" style="display: flex; align-items: center; justify-content: space-between;">
										<div style="display: flex; gap: 30px;">
											<input type="hidden" name="curriculumIdx" value="${curri.curriculumIdx}"/>
											<input type="text" name="curriculumTitle" value="${curri.curriculumTitle}" style="width: 600px">
											<input type="text" name="curriculumRuntime" value="${curri.curriculumRuntime}" style="width: 200px">
										</div>
										<button type="button" onclick="removeCurriculum(this)">삭제</button>
									</div>
								</c:forEach>
							</div>
							<div id="curriculumTemplate" style="display: none;">
								<div class="curriculum-box" style="display: flex; align-items: center; justify-content: space-between;">
									<div style="display: flex; gap: 30px;">
										<input type="hidden" name="curriculumIdx" value="${curri.curriculumIdx}"/>
										<input type="text" name="curriculumTitle" value="${curri.curriculumTitle}" placeholder="커리큘럼 제목" style="width: 600px">
										<input type="text" name="curriculumRuntime" value="${curri.curriculumRuntime}" placeholder="강의 시간"  style="width: 200px">
									</div>
									<button type="button" onclick="removeCurriculum(this)">삭제</button>
								</div>
							</div>
						</div>
						<div class="button-wrapper">
							<button type="button" onclick="back()">닫기</button>
							<c:choose>
								<c:when test="${classInfo.classStatus == 1}">
									<button type="submit" name="action" value="approval"
										formaction="/admin/class/${classInfo.classIdx}/approve"
										formmethod="post">승인</button>
									<button type="button" onclick="onModal()">반려</button>
								</c:when>
								<c:otherwise>
									<button type="submit" name="action" value="update"
										formaction="/admin/class/${classInfo.classIdx}/update"
										formmethod="post"
										>수정</button>
								</c:otherwise>
							</c:choose>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function onModal() {
			const modal = document.querySelector('.modal');
			modal.classList.add("on");
		}
		
		function closeModal() {
			const modal = document.querySelector('.modal');
			modal.classList.remove("on");
		}
		
		function calculateClassDays() {
			let total = 0;
			document.querySelectorAll(".day-checkbox:checked").forEach(cb => {
				total += parseInt(cb.value);
			});
			document.getElementById('classDays').value = total;
		}
		
		document.getElementById("classForm").addEventListener("submit", function (e) {
			calculateClassDays();
		});
		
		function addCurriculum() {
			const container = document.getElementById("curriculumContainer");
			const template = document.getElementById("curriculumTemplate").innerHTML;
			container.insertAdjacentHTML("beforeend", template);
		}
	
		function removeCurriculum(button) {
			const box = button.parentElement;
			box.remove();
		}
		
		function deleteFile(fileId) {

			if(confirm("첨부파일을 삭제하시겠습니까?")) {
				location.href = "/admin/class/fileDelete?fileId=" + fileId + "&classIdx=${classInfo.classIdx}";
			}
		}
		
		function back(pageNum) {
			console.log(pageNum);
			location.href="/admin/classList";
		}
	</script>
</body>
</html>