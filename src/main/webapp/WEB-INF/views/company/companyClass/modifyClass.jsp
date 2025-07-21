<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클래스 수정 페이지</title>
</head>
<body>
    <h2>[ 클래스 수정 ]</h2>
    <form action="/company/myPage/modifyClass" method="post">
        <!-- 기본 정보 -->
        <input type="hidden" name="classIdx" value="${classInfo.classIdx}" />
        <input type="text" name="classTitle" value="${classInfo.classTitle}" placeholder="강좌 제목" /><br/>
        <input type="text" name="classIntro" value="${classInfo.classIntro}" placeholder="강좌 소개" /><br/>
        <input type="text" name="classContent" value="${classInfo.classContent}" placeholder="강좌 내용" /><br/>
        <input type="number" name="classPrice" value="${classInfo.classPrice}" placeholder="가격" /><br/>
        <input type="number" name="classMember" value="${classInfo.classMember}" placeholder="정원" /><br/>
        <input type="text" name="location" value="${classInfo.location}" placeholder="장소" /><br/>
        <input type="date" name="startDate" value="${classInfo.startDate}" />
        <input type="date" name="endDate" value="${classInfo.endDate}" /><br/>

        <!-- 필수: categoryIdx가 빠지면 오류 발생 -->
        <tr>
		  <th>카테고리</th>
		  <td>
		    <!-- 대분류 -->
		    <select id="parentCategory" onchange="filterSubCategories()" style="margin-right: 10px;">
		      <c:forEach var="p" items="${parentCategories}">
		        <option value="${p.categoryIdx}"
		          <c:if test="${fn:startsWith(classInfo.categoryIdx, p.categoryIdx)}">selected</c:if>>
		          ${p.categoryName}
		        </option>
		      </c:forEach>
		    </select>
		
		    <!-- 소분류 -->
		    <select id="subCategory" name="categoryIdx">
		      <c:forEach var="s" items="${subCategories}">
		        <option value="${s.categoryIdx}" data-parent="${s.parentIdx}"
		          <c:if test="${classInfo.categoryIdx eq s.categoryIdx}">selected</c:if>>
		          ${s.categoryName}
		        </option>
		      </c:forEach>
		    </select>
		  </td>
		</tr>

        <!-- 필수: classStatus (1=임시저장, 2=공개, 3=마감) -->
        <select name="classStatus" required>
            <option value="1" ${classInfo.classStatus == 1 ? "selected" : ""}>임시저장</option>
            <option value="2" ${classInfo.classStatus == 2 ? "selected" : ""}>공개</option>
            <option value="3" ${classInfo.classStatus == 3 ? "selected" : ""}>마감</option>
        </select><br/>

        <!-- 필수: 수업요일 classDays -->
        <label><input type="checkbox" class="day" value="1" />월</label>
        <label><input type="checkbox" class="day" value="2" />화</label>
        <label><input type="checkbox" class="day" value="4" />수</label>
        <label><input type="checkbox" class="day" value="8" />목</label>
        <label><input type="checkbox" class="day" value="16" />금</label>
        <label><input type="checkbox" class="day" value="32" />토</label>
        <label><input type="checkbox" class="day" value="64" />일</label>
        <input type="hidden" name="classDays" id="classDays" value="0" /><br/>

        <!-- 커리큘럼 -->
        <c:forEach var="curri" items="${curriculumList}">
            <input type="hidden" name="curriculumIdx" value="${curri.curriculumIdx}" />
            <input type="text" name="curriculumTitle" value="${curri.curriculumTitle}" placeholder="커리큘럼 제목" />
            <input type="text" name="curriculumRuntime" value="${curri.curriculumRuntime}" placeholder="시간" /><br/>
        </c:forEach>
		
		<tr>
			<th>썸네일 이미지 경로</th>
			<td><input type="file" name="classPic1" value="${classInfo.classPic1}"></td>
		</tr>
		
        <button type="submit">수정</button>
    </form>

    <script>
	    // 수정 페이지 처음 열 때 체크된 요일 반영
	    window.addEventListener("DOMContentLoaded", function () {
	        const value = parseInt(document.getElementById("classDays").value || "0");
	        document.querySelectorAll(".day").forEach(cb => {
	            if (value & parseInt(cb.value)) {
	                cb.checked = true;
	            }
	        });
	    });
	
	    // form 제출 전에 선택된 요일 합산
	    document.querySelector("form").addEventListener("submit", function (e) {
	        let total = 0;
	        document.querySelectorAll(".day:checked").forEach(cb => {
	            total += parseInt(cb.value);
	        });
	        document.getElementById("classDays").value = total;
	    });
	</script>
</body>
</html>