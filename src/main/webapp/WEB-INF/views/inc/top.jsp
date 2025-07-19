<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section id="top-menu">
  <a  href="/main.jsp"><img id="logo" alt="logo" src="${pageContext.request.contextPath}/resources/images/logo4-2.png"></a>
  <nav>
      <ul id="flex-item2">
          <li>
              <form action="search" name="search" method="get" id="search-form">
                  <input type="search" id="search" placeholder="검색어를 입력하세요" name="query" required>
              </form>
          </li>
          <li><a id="sub-nav-toggle" href="/course/user/classList?classType=0">정기 강의</a></li>
          <li><a href="/course/user/classList?classType=1">단기 강의</a></li>
          <li><a href="#">고객 센터</a> </li> 
          <li><a href="#">이벤트</a></li>

      </ul>
          
	<div id="sub-nav">
        <ul>
            <li><a href="/course/user/classList?classType=0"><b>정기 강의</b></a></li>
           	<c:forEach var="Pcat" items="${parentCategories}">
           		<li><a href="/course/user/classList?classType=0&categoryIdx=${Pcat.categoryIdx }">
           		${Pcat.categoryName }</a></li>
           		
           	</c:forEach>
        </ul>
        <ul>
            <li><a href="/course/user/classList?classType=1"><b>단기 강의</b></a></li>
			<c:forEach var="Pcat" items="${parentCategories}">
           		<li><a href="/course/user/classList?classType=1&categoryIdx=${Pcat.categoryIdx }">
           		${Pcat.categoryName }</a></li>
           	</c:forEach>
        </ul>
        <ul>
            <li><a href="#"><b>고객 센터</b></a></li>
            <li><a href="#">공지사항</a></li>
            <li><a href="#"> FAQ</a></li> 
            <li><a href="#">문의 게시판</a></li>

        </ul>
        <ul>
            <li><a href="#"><b>이벤트</b></a></li>
            <li><a href="#">얼리버드 할인</a></li>
            <li><a href="#">특별 할인</a></li> 
        </ul>
      
	</div> 
	</nav>  
       <div id="header-buttons">
           <a id="noti" href="/home/notification"><img alt="notification" src="${pageContext.request.contextPath}/resources/images/notification.png"></a>
           <a class="button header-button">마이페이지</a>
           <c:choose>
				<c:when test="${empty sessionScope.sId}">
		            <a href="/user/login" class="header-button button">로그인</a>
				</c:when>
				<c:otherwise>
					<a class="header-button button" href="javascript:void(0)" onclick="logout()">로그아웃</a>  
					<c:if test="${sessionScope.sId eq 'admin'}">
						 <a class="header-button button" href="/admin/main">management page</a>
					</c:if>
				</c:otherwise>
			</c:choose>
    	</div>
</section>
