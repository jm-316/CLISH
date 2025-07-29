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
						<form action="/admin/event/write" method="post" enctype="multipart/form-data">
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
											<input type="file" name="contentFile" />
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
											<label for="start-datetime">시작날짜</label>
											<input type="date" id="start-datetime" name="eventStartDate" required/>
											<label for="end-datetime">종료날짜</label>
											<input type="date" id="end-datetime" name="eventEndDate" required/>
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
</body>
</html>