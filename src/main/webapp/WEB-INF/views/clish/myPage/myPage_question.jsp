<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 문의</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com" >
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Nanum+Myeongjo&family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Orelega+One&display=swap" rel="stylesheet">
<style>
	.inquery-toggle { cursor: pointer; background: #f9f9f9; }
	.inquery-detail { display: none; background: #fff4d9; }
	.btn-wrap {
		display: flex;
		gap: 16px;
		margin-top: 10px;
		justify-content: flex-end;
	}
	.btn-wrap form {
		margin: 0;
		padding: 0;
		border: none;        
		background: none;     
		box-shadow: none;     
		display: inline;   
	    
	}
	.btn-wrap button:hover {
		background: #ff9c34;
	}
	
	.pageSection {
		text-align: center;
		border: none;
	}

</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<main id="container">
	
	<jsp:include page="/WEB-INF/views/clish/myPage/side.jsp"></jsp:include>
	
	<div id="main">
	
		<h1>${sessionScope.sId}의 페이지</h1>
		<hr>
		<div>
			<h3>강의 문의</h3>
			<table border="1" style="width: 100%; border-collapse: collapse;">
				<thead style="background-color: #f5f5f5;">
	   			<tr>
	      			<th>문의 번호</th>
	      			<th>문의 시간</th>
				    <th>이름</th>
				    <th>강의명</th>
				    <th>제목</th>
				    <th>상태</th>
			    </tr>
			    </thead>
			  	<tbody>
				  	<c:forEach var="classQ" items="${classQDTOList}">
					    <tr class="inquery-toggle">
					    	<td>${classQ.inqueryIdx}</td>
					    	<td><fmt:formatDate value="${classQ.inqueryDatetime }" pattern="MM-dd HH:mm:ss"/></td>
					      	<td>${user.userName}</td>
					      	<td>${classQ.classTitle }</td>
					      	<td>${classQ.inqueryTitle}</td>
					      	<td>
					        <c:choose>
					        	<c:when test="${classQ.inqueryStatus == 1}">답변대기</c:when>
					          	<c:when test="${classQ.inqueryStatus == 2}">답변완료</c:when>
					       	 	<c:when test="${classQ.inqueryStatus == 3}">검토중</c:when>
					        </c:choose>
					     	</td>
					    </tr>
					
					    <tr class="inquery-detail">
					      	<td colspan="6">
						        <strong>문의 내용:</strong><br>
						        	${classQ.inqueryDetail}<br><br>
						        <strong>답변 내용:</strong><br>
						        <c:if test="${not empty classQ.inqueryAnswer}">
						        	  ${classQ.inqueryAnswer}
						        </c:if>
						        <c:if test="${empty classQ.inqueryAnswer}">
						         	 아직 답변이 등록되지 않았습니다.
						        </c:if>
						
						        <c:if test="${classQ.inqueryStatus == 1}">
						          	<div class="btn-wrap" style="text-align: right;">
							            <form action="/myPage/myQuestion/inquery/modify" method="get" style="display:inline; text-align: right;">
							            	<input type="hidden" name="inqueryIdx" value="${classQ.inqueryIdx}">
							            	<button type="submit">수정</button>
							            </form>
							            <form action="/myPage/myQuestion/inquery/delete" method="post" style="display:inline; text-align: right;">
							              	<input type="hidden" name="inqueryIdx" value="${classQ.inqueryIdx}">
							              	<button type="submit" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
							            </form>
						          	</div>
						        </c:if>
					    	</td>
					    </tr>
				  	</c:forEach>
			  	</tbody>
		  	</table>
			<section id="inqueryList" class="pageSection">
				<c:if test="${not empty classQPageInfo.maxPage or classQPageInfo.maxPage > 0}">
					<input type="button" value="이전" 
						onclick="location.href='/myPage/myQuestion?classQuestionPageNum=${classQPageInfo.pageNum - 1 }&inqueryPageNum=${inqueryPageInfo.pageNum}'" 
						<c:if test="${classQPageInfo.pageNum eq 1}">disabled</c:if>
					>
					
					<c:forEach var="i" begin="${classQPageInfo.startPage}" end="${classQPageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq classQPageInfo.pageNum}">
								<strong>${i}</strong>
							</c:when>
							<c:otherwise>
								<a href="/myPage/myQuestion?classQuestionPageNum=${i}&inqueryPageNum=${inqueryPageInfo.pageNum}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<input type="button" value="다음" 
						onclick="location.href='/myPage/myQuestion?classQuestionPageNum=${classQPageInfo.pageNum + 1}&inqueryPageNum=${inqueryPageInfo.pageNum}'" 
						<c:if test="${classQPageInfo.pageNum eq classQPageInfo.maxPage}">disabled</c:if>
					>
				</c:if>
			</section>
		</div>
		<div>
			<h3>고객센터 문의</h3>
			<table border="1" style="width: 100%; border-collapse: collapse;">
				<thead style="background-color: #f5f5f5;">
	   			<tr>
	      			<th>문의 번호</th>
	      			<th>문의 시간</th>
				    <th>이름</th>
				    <th>제목</th>
				    <th>상태</th>
			    </tr>
			    </thead>
			  	<tbody>
				  	<c:forEach var="inquery" items="${inqueryDTOList}">
					    <tr class="inquery-toggle">
					    	<td>${inquery.inqueryIdx}</td>
					    	<td><fmt:formatDate value="${inquery.inqueryDatetime }" pattern="MM-dd HH:mm:ss"/></td>
					      	<td>${user.userName}</td>
					      	<td>${inquery.inqueryTitle}</td>
					      	<td>
						        <c:choose>
						        	<c:when test="${inquery.inqueryStatus == 1}">답변대기</c:when>
						          	<c:when test="${inquery.inqueryStatus == 2}">답변완료</c:when>
						       	 	<c:when test="${inquery.inqueryStatus == 3}">검토중</c:when>
						        </c:choose>
					     	</td>
					    </tr>
					
					    <tr class="inquery-detail">
					      	<td colspan="5">
						        <strong>문의 내용:</strong><br>
						        	${inquery.inqueryDetail}<br><br>
						        <strong>답변 내용:</strong><br>
						        <c:if test="${not empty inquery.inqueryAnswer}">
						        	  ${inquery.inqueryAnswer}
						        </c:if>
						        <c:if test="${empty inquery.inqueryAnswer}">
						         	 아직 답변이 등록되지 않았습니다.
						        </c:if>
						
						        <c:if test="${inquery.inqueryStatus == 1}">
						          	<div class="btn-wrap">
							            <form action="/myPage/myQuestion/inquery/modify" method="get" style="display:inline;">
							            	<input type="hidden" name="inqueryIdx" value="${inquery.inqueryIdx}">
							            	<button type="submit">수정</button>
							            </form>
							            <form action="/myPage/myQuestion/inquery/delete" method="post" style="display:inline;">
							              	<input type="hidden" name="inqueryIdx" value="${inquery.inqueryIdx}">
							              	<button type="submit" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
							            </form>
						          	</div>
						        </c:if>
					    	</td>
					    </tr>
				  	</c:forEach>
			  	</tbody>
		  	</table>
			<section id="inqueryList" class="pageSection">
				<c:if test="${not empty inqueryPageInfo.maxPage or inqueryPageInfo.maxPage > 0}">
					<input type="button" value="이전" 
						onclick="location.href='/myPage/myQuestion?classQuestionPageNum=${classQuestionPageInfo.pageNum }&inqueryPageNum=${inqueryPageInfo.pageNum - 1}'" 
						<c:if test="${inqueryPageInfo.pageNum eq 1}">disabled</c:if>
					>
					
					<c:forEach var="i" begin="${inqueryPageInfo.startPage}" end="${inqueryPageInfo.endPage}">
						<c:choose>
							<c:when test="${i eq inqueryPageInfo.pageNum}">
								<strong>${i}</strong>
							</c:when>
							<c:otherwise>
								<a href="/myPage/myQuestion?classQuestionPageNum=${classQuestionPageInfo.pageNum}&inqueryPageNum=${i}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<input type="button" value="다음" 
						onclick="location.href='/myPage/myQuestion?classQuestionPageNum=${classQuestionPageInfo.pageNum}&inqueryPageNum=${inqueryPageInfo.pageNum + 1}'" 
						<c:if test="${inqueryPageInfo.pageNum eq inqueryPageInfo.maxPage}">disabled</c:if>
					>
				</c:if>
			</section>
		</div>
	
	</div>
	
	</main>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
	</footer>
	<script>
	  $(document).ready(function () {
	    $(".inquery-toggle").click(function () {
	      const detailRow = $(this).next(".inquery-detail");
	
	      $(".inquery-detail").not(detailRow).slideUp();
	
	      if (!detailRow.is(":visible")) {
	        detailRow.slideDown();
	      } else {
	        detailRow.slideUp();
	      }
	    });
	  });
	</script>
</body>
</html>