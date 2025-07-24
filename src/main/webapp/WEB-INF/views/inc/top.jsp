<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<section id="top-menu">
  <a  href="/"><img id="logo" alt="logo" src="${pageContext.request.contextPath}/resources/images/logo4-2.png"></a>
  <nav>
      <ul id="flex-item2">
          <li>
              <form action="search" name="search" method="get" id="search-form">
                  <input type="search" id="search" placeholder="검색어를 입력하세요" name="query" required>
              </form>
          </li>
          <li><a id="sub-nav-toggle" href="/course/user/classList?classType=0">정기 강의</a></li>
          <li><a href="/course/user/classList?classType=1">단기 강의</a></li>
          <li><a href="/customer/customerCenter">고객 센터</a> </li> 
          <li><a href="/event/eventHome">이벤트</a></li>

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
            <li><a href="/customer/customerCenter"><b>고객 센터</b></a></li>
            <li><a href="/customer/announcements">공지사항</a></li>
            <li><a href="/customer/FAQ"> FAQ</a></li> 
            <li><a href="/customer/inquiry">문의 게시판</a></li>

        </ul>
        <ul>
            <li><a href="/event/eventHome"><b>이벤트</b></a></li>
            <li><a href="/event/earlyDiscount">얼리버드 할인</a></li>
            <li><a href="/event/specialDiscount">특별 할인</a></li> 
        </ul>
      
	</div> 
	</nav>  
      <div id="header-buttons">
           <a id="noti" href="javascript:void(0)" onclick="notification()"><img alt="notification" src="${pageContext.request.contextPath}/resources/images/notification.png"></a>
           		<div id="notification-box">
           			<h3>알림</h3>
           			<ul>
           				<li onmouseover="changeNotiColor(e)" >notification 1 <span >🔴</span></li>
           				<li>notification 2 <span onmouseover="changeNotiColor(e)">🔴</span></li>
           				<li>notification 3 <span onmouseover="changeNotiColor(e)">🔴</span></li>
           			</ul>
           		</div>
           <c:choose>
				<c:when test="${empty sessionScope.sId}">
		           <a class="button header-button" href="/user/join">회원 가입</a>
		            
				</c:when>
				<c:otherwise>
					 
					<c:if test="${sessionScope.userType == 3}">
						 <a class="header-button button" href="/admin/main">마이페이지</a>
					</c:if>
					<c:if test="${sessionScope.userType == 2}">
						 <a class="header-button button" href="/company/main">마이페이지</a>
					</c:if>
					<c:if test="${sessionScope.userType == 1}">
		          		 <a class="button header-button" href="/clish/myPage/main">마이페이지</a>
					</c:if>
				</c:otherwise>
			</c:choose>
			 <c:choose>
				<c:when test="${empty sessionScope.sId}">
		            <a href="/user/login" class="header-button button">로그인</a>
				</c:when>
				<c:otherwise>
					<a class="header-button button" href="javascript:void(0)" onclick="logout()">라그아웃</a>  
				</c:otherwise>
			</c:choose>
    	</div>
    	<script type="text/javascript">
	    	const notiButton = document.getElementById('notification-box');
    		function notification() {
    			notiButton.style.display = "block";
    		}
    	
    		notiButton.addEventListener('mouseleave', () => {
    		    notiButton.style.display = 'none';
    		});
    		function changeNotiColor(e) {
    			e.target.innerText = "";
    		}
    	</script>
</section>
