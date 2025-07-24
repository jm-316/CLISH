<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/the_best_styles.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="sidebar" id="sidebar">
		<div class="sidebar-toggle" onclick="toggleSidebar()">≡</div>
		
		<c:choose>
			<c:when test="${param.classType eq 0}">
				<c:set var="classType" value="정기 강의" />
			</c:when>
			<c:otherwise>
				<c:set var="classType" value="단기 강의" />
			</c:otherwise>
		</c:choose>
	
		<ul class="category-list">
			<c:if test="${param.classType eq 0 or param.classType eq 1}">
				<li class="sidebar-title">
					<a href="/course/user/classList?classType=${param.classType}">
						<strong>${classType}</strong>
					</a>
				</li>
				
				<c:forEach var="Pcat" items="${parentCategories}">
			      <li class="parent-category">
			        <span onclick="toggleSubmenu(this)">${Pcat.categoryName} ▼</span>
			        <ul class="child-category">
			          <c:forEach var="Ccat" items="${childCategories}">
			            <c:if test="${Ccat.parentIdx eq Pcat.categoryIdx}">
			              <li>
			                <a href="/course/user/classList?classType=${param.classType}&categoryIdx=${Ccat.categoryIdx}">
			                  ${Ccat.categoryName}
			                </a>
			              </li>
			            </c:if>
			          </c:forEach>
			        </ul>
			      </li>
			    </c:forEach>
			</c:if>
		</ul>
	</div>
</body>
</html>