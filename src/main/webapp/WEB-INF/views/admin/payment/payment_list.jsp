<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
</head>
<body>
	<div class="container">
		<div class="sidebar">
			<jsp:include page="/WEB-INF/views/admin/sidebar.jsp"></jsp:include>
		</div>
		<div class="main">
			<div class="navbar-expand">
				<h4 class="pageSubject">CLISH 관리자 대시보드</h4>
				<div>관리자</div>
			</div>
			<div class="main_container">
				<div class="bg-light">
					<div>
						<div>
							<h5 class="section-title">결제 목록</h5>
						</div>
						<div class="sort-buttons">
							<button class="sort-button" data-value="all">전체</button>
						    <button class="sort-button" data-value="recent">최신순</button>
						    <button class="sort-button" data-value="oldest">과거순</button>
						    <button class="sort-button" data-value="long">장기강의</button>
						    <button class="sort-button" data-value="short">단기강의</button>
						</div>
					</div>
					<div>
						<c:choose>
							<c:when test="${empty paymentList}">
								<div class="list-empty">결제된 강의가 없습니다.</div>
							</c:when>
							<c:otherwise>
								<table id="table">
									<thead>
										<tr>
											<th>결제번호</th>
											<th>결제일시</th>
											<th>결제강의</th>
											<th>회원이름</th>
											<th>결제금액</th>
											<th>결제상태</th>
											<th>상세정보</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="payment" items="${paymentList}">
											<tr>
												<td>${payment.impUid}</td>
												<td>${payment.payTimeFormatted}</td>
												<td>${payment.classTitle}</td>
												<td>${payment.userName}</td>
												<td><fmt:formatNumber value="${payment.amount}" type="number" groupingUsed="true"/> 원</td>
												<td>
													<c:choose>
														<c:when test="${payment.status eq 'paid'}">
															<span class="status-paid">결제완료</span>
														</c:when>
														<c:otherwise>
															<span class="status-cancelled">결제취소</span>
														</c:otherwise>
													</c:choose>
												</td>
<%-- 												<td>${payment.status}</td> --%>
												<td>
													<button onclick="paymentInfo('${payment.impUid}', '${payment.status}')">상세정보</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function paymentInfo(impUid, status) {
			if(status == 'paid'){
				window.open(
					'/admin/payment_info/paymentDetail?impUid=' + encodeURIComponent(impUid),			
					'paymentInfo',
					`width=600,height=1500, resizable=yes, scrollbars=yes`
				);
			}
			if(status == 'cancelled'){
				window.open(
						'/admin/payment_info/cancelDetail?impUid=' + encodeURIComponent(impUid),			
						'paymentInfo',
						`width=600,height=1500, resizable=yes, scrollbars=yes`
				);
			}
		}
	</script>
</body>
</html>