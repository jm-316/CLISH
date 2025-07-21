<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/home.js"></script>

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<main class="main">
		 <div class="main_container">
           <div style="border: 1px solid black;">
                <h5>강좌 목록</h5>
           </div>
           <div class="filter" style="border: 1px solid black;">
               <select>
                    <option>전체</option>
                    <option>최신등록순</option>
               </select> 
               <div>
                    <input type="text" />
               </div>
           </div>
           <div>
                <table class="table">
                    <thead>
                        <tr>
	           				<th>제목</th>
	           				<th>대분류</th>
	           				<th>소분류</th>
	           				<th>상태</th>
                            <th colspan="2"></th>
                        </tr>
                    </thead>
                    <tbody>
           		   		<c:set var="hasRegisteredClass" value="false" />
						<c:forEach var="classItem" items="${classList}">
						    <c:if test="${classItem.classStatus != 1}">
						        <c:set var="hasRegisteredClass" value="true" />
						        <tr>
						            <td onclick="location.href='/course/user/classDetail?classIdx=${classItem.classIdx}'">${classItem.classTitle}</td>
						            <!-- 대분류 -->
									<c:forEach var="Pcat" items="${parentCategories}">
										<c:forEach var="Ccat" items="${childCategories}">
											<c:if test="${classItem.categoryIdx eq Ccat.categoryIdx}">
												<td>${Pcat.categoryName}</td>
											</c:if>
										</c:forEach>
									</c:forEach>
									<!-- 소분류 -->
									<c:forEach var="Pcat" items="${parentCategories}">
										<c:forEach var="Ccat" items="${childCategories}">
											<c:if test="${Pcat.categoryIdx eq Ccat.parentIdx}">
												<td>${Ccat.categoryName}</td>
											</c:if>
										</c:forEach>
									</c:forEach>
						            <td>
						                <c:choose>
						                    <c:when test="${classItem.classStatus == 2}">오픈</c:when>
						                    <c:otherwise>마감</c:otherwise>
						                </c:choose>
						            </td>
					            	<c:if test="${user.userType eq 1}">
							            <td><button onclick="location.href='/course/user/courseReservation?classIdx=${classItem.classIdx}'">예약</button></td>
					            	</c:if>
					            	<c:if test="${user.userType eq 2}">
							            <td><button onclick="location.href='/company/myPage/modifyClass?classIdx=${classItem.classIdx}'">수정</button></td>
					            	</c:if>
						        </tr>
						    </c:if>
						</c:forEach>
						<c:if test="${not hasRegisteredClass}">
						    <tr><td colspan="5">등록된 강의가 없습니다.</td></tr>
						</c:if>
	                    
                    </tbody>
                    
                </table>
           </div>
        </div>
        <nav class="side-nav">
		    <ul>
		    	<c:if test="${param.classType eq 0}">
					<li><a href="/course/user/classList?classType=0"><b>정기 강의</b></a></li>
		           	<c:forEach var="Pcat" items="${parentCategories}">
		           		<li><a href="/course/user/classList?classType=0&categoryIdx=${Pcat.categoryIdx}">
		           		${Pcat.categoryName}</a></li>
		           		<c:forEach var="Ccat" items="${childCategories}">
		           			<c:if test="${Ccat.parentIdx eq Pcat.categoryIdx}">
				           		<li><a href="/course/user/classList?classType=0&categoryIdx=${Ccat.categoryIdx}">
				           		${Ccat.categoryName}</a></li>
		           			</c:if>
		           		</c:forEach>
		           	</c:forEach>		
		    	</c:if>
		    	<c:if test="${param.classType eq 1}">
					<li><a href="/course/user/classList?classType=1"><b>단기 강의</b></a></li>
		           	<c:forEach var="Pcat" items="${parentCategories}">
		           		<li><a href="/course/user/classList?classType=1&categoryIdx=${Pcat.categoryIdx}">
		           		${Pcat.categoryName }</a></li>
		           		<c:forEach var="Ccat" items="${childCategories}">
		           			<c:if test="${Ccat.parentIdx eq Pcat.categoryIdx}">
				           		<li><a href="/course/user/classList?classType=1&categoryIdx=${Ccat.categoryIdx}">
				           		${Ccat.categoryName}</a></li>
		           			</c:if>
		           		</c:forEach>
		           	</c:forEach>		
		    	</c:if>
		    </ul>
		</nav>
	</main>
	<footer>
		<jsp:include page="/WEB-INF/views/admin/bottom.jsp" />
	</footer>

</body>
</html>