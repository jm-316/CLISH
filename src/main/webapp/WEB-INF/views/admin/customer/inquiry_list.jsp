<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/resources/css/admin/modal.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<c:if test="${not empty msg}">
		<script>
	    	alert("${msg}");
	    </script>
	</c:if>
	<div class="container">
		<div class="sidebar">
			<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"></jsp:include>	
		</div>
		<div class="modal" id="inquiry-modal">
			<div class="modal_body">
				<h3>문의 상세 보기</h3>
				<form id="modal-form" action="/admin/inquiry/write" method="post" >
					<input type="hidden" name="inqueryIdx" id="inquiry-idx"/>
					<input type="hidden" name="userIdx" id="user-idx"/>
					<table>
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tbody>
							<tr>
								<th>작성자</th>
								<td><span id="inquiry-user"></span></td>
							</tr>
							<tr>
								<th>작성일</th>
								<td><span id="inquiry-date"></span></td>
							</tr>
							<tr>
								<th>문의유형</th>
								<td><span id="inquiry-type"></span></td>
							</tr>
							<tr>
								<th>문의내용</th>
								<td><div id="inquiry-detail"></div></td>
							</tr>
							<tr>
								<th>답변</th>
								<td><textarea rows="10" cols="10" id="inquiry-answer" name="inqueryAnswer"></textarea></td>
							</tr>
						</tbody>
					</table>
					<div class="button-wrapper">
						<button type="submit" id="btn"></button>
						<button type="button" onclick="location.href='/admin/inquiry'">취소</button>
					</div>
				</form>
			</div>
		</div>
		<div class="main">
			<jsp:include page="/WEB-INF/views/admin/header.jsp"></jsp:include>
			<div class="main_container">
				<div class="bg-light">
					<div>
						<div class="flex">
							<h5 class="section-title">문의관리</h5>
						</div>
					</div>
					<div>
						<div>
							<table>
								<thead>
									<tr>
										<th>게시판번호</th>
										<th>문의유형</th>
										<th>제목</th>
										<th>작성자</th>
										<th>등록일</th>
										<th>답변여부</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="inquiry" items="${inquiryList}" varStatus="status" >
										<tr onclick="onModal('${inquiry.inquiry.inqueryIdx}')">
											<td>${status.index + 1}</td>
											<td>1:1문의</td>
											<td>${inquiry.inquiry.inqueryTitle}</td>
											<td>${inquiry.userName}</td>
											<td><fmt:formatDate value="${inquiry.inquiry.inqueryDatetime}" pattern="yyyy-MM-dd" /></td>
											<td>											
												<c:choose>
													<c:when test="${inquiry.inquiry.inqueryStatus eq 1}">미답변</c:when>
													<c:when test="${inquiry.inquiry.inqueryStatus eq 2}">답변완료</c:when>
													<c:otherwise>보류</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>									
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function onModal(inqueryIdx) {
			const modal = document.querySelector('#inquiry-modal');
		  	modal.style.display = "block";

			fetch("/admin/inquiry/detail/" + inqueryIdx)
		      .then(res => res.json())
		      .then(data => {
		       	 document.querySelector("#inquiry-idx").value = data.inquiry.inqueryIdx;
		       	 document.querySelector("#user-idx").value = data.inquiry.userIdx;
		       	 document.querySelector("#inquiry-user").innerText = data.userName;
		       	 document.querySelector("#inquiry-date").innerText = formattedDate(data.inquiry.inqueryDatetime);
		       	 document.querySelector("#inquiry-type").innerText = data.inqueryType === 1 && "1:1문의";
		         document.querySelector("#inquiry-detail").innerText = data.inquiry.inqueryDetail;
		         document.querySelector("#inquiry-answer").value = data.inquiry.inqueryAnswer || "";
		         document.querySelector("#btn").textContent = data.inquiry.inqueryAnswer ? "수정" : "등록";
		    })
		      .catch(err => console.error("문의 상세 조회 실패", err));
		}

		function formattedDate(timestamp) {
			const date = new Date(timestamp);
			const fmt = date.toLocaleString("ko-KR", {
				year: "numeric",
				month: "2-digit",
				day: "2-digit",
				hour: "2-digit",
			});
			
			return fmt;
		}
	</script>
</body>
</html>