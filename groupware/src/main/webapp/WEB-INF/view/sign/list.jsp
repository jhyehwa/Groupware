﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>


<div class="container">
    <div class="board-container">
        <div class="body-title">
            <h3>공지사항 </h3>
        </div>
        
        <div class="board-body">
			<table style="margin-top: 20px;">
			   <tr>
			      <td align="left">
			          &nbsp;
			      </td>
			      <td align="right">
			          ${dataCount}개(${page}/${total_page} 페이지)
			      </td>
			   </tr>
			</table>
			
			<table style="border-collapse: collapse;">
			  <tr align="center" bgcolor="#006461;"> 
			      <th width="60">번호</th>
			      <th>제목</th>
			      <th width="100">작성자</th>
			      <th width="80">작성일</th>
			      <th width="60">조회수</th>
			  </tr>
			<c:forEach var="dto" items="${list}">
			  <tr align="center" style="border-bottom: 1px solid #cccccc;"> 
			      <td>${dto.listNum}</td>
			      <td align="left" style="padding-left: 10px;">
			           <a href="${articleUrl}&noticeNum=${dto.noticeNum}">${dto.title}</a>
			           <c:if test="${dto.gap < 24}">
		               	<i class="fas fa-ad"></i>
		          	   </c:if>
			      </td>
			      <td>${dto.name}</td>
			      <td>${dto.created}</td>
			      <td>${dto.hitCount}</td>
			  </tr>
			</c:forEach>
			</table>
			 
			<table style="margin: 10px 0 0 100px;">
			   <tr>
				<td class="board-paging" align="center">
			         ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
				</td>
			   </tr>
			</table>
			
			<table style="margin-top: 10px ">
			   <tr height="40">
			      <td align="left" width="100">
			          <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/notice/list';">새로고침</button>
			      </td>
			      <td align="center">
			          <form name="searchForm" action="<%=cp%>/notice/list" method="post">
			              <select name="condition" class="selectField">
			                  <option value="title" ${condition=="title"?"selected='selected'":""}>제목</option>
			                  <option value="name" ${condition=="name"?"selected='selected'":""}>작성자</option>
			                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
			                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
			            </select>
			            <input type="text" name="keyword" class="boxTF">
			            <button type="button" class="boardBtn" onclick="searchList()">검색</button>
			        </form>
			      </td>
			      <td align="right" width="100">
			          <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/notice/created';">글올리기</button>
			      </td>
			   </tr>
			</table>
        </div>
    </div>
</div>
