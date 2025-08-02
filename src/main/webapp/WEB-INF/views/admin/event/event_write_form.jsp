<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="sidebar">
			<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"></jsp:include>	
		</div>
		<div class="main">
			<jsp:include page="/WEB-INF/views/admin/header.jsp"></jsp:include>
			<div class="main_container">
				<div class="bg-light">
					<div>
						<div>
							<h5 class="section-title">이벤트 등록</h5>
						</div>
					</div>
					<div>
						<form action="/admin/event/write" method="post" enctype="multipart/form-data" id="eventForm">
							<table>
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
								<tbody>
									<tr>
										<th>제목<span style="vertical-align: middle; margin-left: 5px; color: red;">*</span></th>
										<td><input type="text" name="eventTitle" id="eventTitle" required/></td>
									</tr>
									<tr>
										<th>썸네일<span style="vertical-align: middle; margin-left: 5px; color: red;">*</span></th>
										<td>
											<input type="file" name="thumbnailFile" required />
											<input type="hidden" name="fileTypes" value="thumbnail" />
										</td>
									</tr>
									<tr>
										<th>이벤트페이지<span style="vertical-align: middle; margin-left: 5px; color: red;">*</span></th>
										<td>
											<input type="file" name="contentFile" required/>
											<input type="hidden" name="fileTypes" value="content" />
										</td>
									</tr>
									<tr>
										<th>내용</th>
										<td><textarea rows="5" cols="5" name="eventDescription" id="eventDescription"></textarea></td>
									</tr>
									<tr>
										<th>적용기간<span style="vertical-align: middle; margin-left: 5px; color: red;">*</span></th>
										<td>
											<div style="display: flex; align-items: center; justify-content: space-between;">
												<div style="width: 400px;">
													<label for="startDate">시작날짜</label>
													<input type="date" id="startDate" name="eventStartDate" required/>
												</div>
												<div style="width: 400px;">
													<label for="endDate">종료날짜</label>
													<input type="date" id="endDate" name="eventEndDate" required/>
												</div>
											</div>
											<span id="startDateError" style="color: red; display: none;"></span>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="button-wrapper">
								<button type="submit" >등록</button>
								<button type="button" onclick="history.back()">취소</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		document.getElementById("eventForm").addEventListener("submit", (e) => {
			// 날짜 비교 검사
			const startInput = document.getElementById("startDate");
			const endInput = document.getElementById("endDate");
			const errorSpan = document.getElementById("startDateError");
			
			const startDate = new Date(startInput.value);
			const endDate = new Date(endInput.value);
			const today = new Date();
			
			if (startDate < today) {
				errorSpan.textContent = "시작 날자는 오늘보다 뒤일 수 없습니다."
				errorSpan.style.display = "block";
				e.preventDefault();
			    return;
			} else {
		      errorSpan.textContent = "";
		      errorSpan.style.display = "none";
			}
			
			if (endDate.getTime() < startDate.getTime()) {
				alert("종료일이 시작일보다 빠를 수 없습니다.");
				e.preventDefault();
				return;
			}
			
		});
	
	</script>
</body>
</html>