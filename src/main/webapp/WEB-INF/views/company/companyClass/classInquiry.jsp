<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 문의 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/the_best_styles.css">
<link href="${pageContext.request.contextPath}/resources/css/home/top.css" rel="stylesheet" >
<style>
  .classManage-container {
    display: flex;
    width: 100%;
    min-height: 100vh;
  }
  .content-area {
    flex: 1;
    padding: 30px;
  }
  .class-header {
    margin-bottom: 30px;
    text-align: center;
  }
  .class-table {
    width: 100%;
    border-collapse: collapse;
  }
  .class-table th, .class-table td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
  }
  .class-table tr:hover {
    background-color: #f5f5f5;
    cursor: pointer;
  }
  .modal {
    display: none;
    position: fixed;
    top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0,0,0,0.5);
    justify-content: center;
    align-items: center;
    z-index: 999;
  }
  .modal_body {
	 background: white;
	 padding: 30px;
	 border-radius: 10px;
	 width: 550px;
	 box-shadow: 0 5px 20px rgba(0,0,0,0.2);
	 display: flex;
	 flex-direction: column;
	 align-items: center;  /* 가운데 정렬 핵심 */
	}
  .modal_body table {
    width: 100%;
    border-collapse: collapse;
    margin: 0 auto; 
  }
  .modal_body th, .modal_body td {
    padding: 10px;
    text-align: left;
  }
  .modal-buttons {
    text-align: center;
    margin-top: 20px;
  }
</style>
</head>
<body>
	<header>
	  <jsp:include page="/WEB-INF/views/inc/top.jsp"></jsp:include>
	</header>
	
	<div class="classManage-container">
	  <jsp:include page="/WEB-INF/views/company/comSidebar.jsp" />
	  <div class="content-area">
	    <div class="class-header">
	      <h1>클래스 문의 페이지</h1>
	    </div>
	    <c:choose>
	      <c:when test="${empty classInquiryList}">
	        <div class="no-data">등록된 문의가 없습니다.</div>
	      </c:when>
	      <c:otherwise>
	        <table class="class-table">
	          <thead>
	            <tr>
	              <th>문의 번호</th>
	              <th>제목</th>
	              <th>작성자</th>
	              <th>문의일자</th>
	              <th>답변 상태</th>
	            </tr>
	          </thead>
	          <tbody>
	            <c:forEach var="inq" items="${classInquiryList}">
	              <tr onclick="showModal('${inq.inquiry.inqueryIdx}')">
	                <td>${inq.inquiry.inqueryIdx}</td>
	                <td>${inq.inquiry.inqueryTitle}</td>
	                <td>${inq.userName}</td>
	                <td><fmt:formatDate value="${inq.inquiry.inqueryDatetime}" pattern="yyyy-MM-dd" /></td>
	                <td>
	                  <c:choose>
	                    <c:when test="${empty inq.inquiry.inqueryAnswer}">미답변</c:when>
	                    <c:otherwise>답변완료</c:otherwise>
	                  </c:choose>
	                </td>
	              </tr>
	            </c:forEach>
	          </tbody>
	        </table>
	      </c:otherwise>
	    </c:choose>
	  </div>
	</div>
	
	<!-- 문의 상세 모달 -->
	<div class="modal" id="inquiry-modal">
	  <div class="modal_body">
	    <h3>문의 상세 보기</h3>
	    <table>
	      <tr><th>작성자</th><td id="modal-writer"></td></tr>
	      <tr><th>작성일</th><td id="modal-date"></td></tr>
	      <tr><th>문의유형</th><td id="modal-type"></td></tr>
	      <tr><th>문의내용</th><td id="modal-detail"></td></tr>
	      <tr>
	        <th>답변</th>
	        <td>
	          <textarea id="modal-answer" rows="5" style="width:100%"></textarea>
	        </td>
	      </tr>
	    </table>
	    <div class="modal-buttons">
	      <button onclick="submitAnswer()">등록</button>
	      <button onclick="closeModal()">취소</button>
	    </div>
	  </div>
	</div>
	
	<footer>
	  <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>

	<script>
	  function showModal(inqueryIdx) {
	    fetch('/company/inquiry/detail/' + inqueryIdx)
	      .then(res => res.json())
	      .then(data => {
	        document.getElementById('modal-writer').innerText = data.userName;
	        document.getElementById('modal-date').innerText = formatFullDate(data.inquiry.inqueryDatetime);
	        document.getElementById('modal-type').innerText = data.inquiry.inqueryType === 1 ? '1:1문의' : '클래스문의';
	        document.getElementById('modal-detail').innerText = data.inquiry.inqueryDetail;
	        document.getElementById('modal-answer').value = data.inquiry.inqueryAnswer || '';
	        document.getElementById('inquiry-modal').style.display = 'flex';
	        
	        // 전역변수로 현재 문의 번호 기억
	        window.currentInquiryIdx = data.inquiry.inqueryIdx;
	      });
	  }
	
	  function closeModal() {
	    document.getElementById('inquiry-modal').style.display = 'none';
	  }
	
	  function formatFullDate(datetimeStr) {
	    const date = new Date(datetimeStr);
	    const options = {
	      year: 'numeric', month: '2-digit', day: '2-digit',
	      hour: '2-digit', minute: '2-digit', hour12: true
	    };
	    return date.toLocaleString("ko-KR", options);
	  }
	
	  // 추후 서버로 등록 전송 시 사용될 함수 (선택사항)
	  function submitAnswer() {
	    const answer = document.getElementById('modal-answer').value;
	
	    fetch('/company/inquiry/answer', {
	      method: 'POST',
	      headers: {
	        'Content-Type': 'application/json'
	      },
	      body: JSON.stringify({
	        inqueryIdx: window.currentInquiryIdx,
	        answer: answer
	      })
	    })
	    .then(res => res.text())
	    .then(result => {
	      alert("답변이 등록되었습니다.");
	      closeModal();
	      location.reload();
	    })
	    .catch(() => {
	      alert("오류가 발생했습니다.");
	    });
	  }
	</script>
</body>
</html>