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

<div class="body-container">
    <div class="body-title">
        <h3><i class="far fa-clipboard"></i> Community </h3>
    </div>
    
    <div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
		   <tr height="35">
		      <td align="left" width="50%">
		          ${dataCount}개(${page}/${total_page} 페이지)
		      </td>
		      <td align="right">
		          &nbsp;
		      </td>
		   </tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
		  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
		      <th width="60" style="color: #787878;">번호</th>
		      <th width="60" style="color: #787878;">동호회명</th>
		      <th style="color: #787878;">제목</th>
		      <th width="80" style="color: #787878;">작성자</th>
		      <th width="80" style="color: #787878;">작성일</th>
		      <th width="50" style="color: #787878;">조회수</th>
		      <th width="50" style="color: #787878;">첨부</th>
		  </tr>
		 
		<c:forEach var="dto" items="${commuList}">
		  <tr align="center" bgcolor="#006461;" height="35" style="border-bottom: 1px solid #cccccc;"> 
		      <td><span style="display: inline-block;padding:1px 3px; background: #ED4C00;color: #FFFFFF">공지</span></td>
		      <td>${dto.clubCode}</td>
		      <td align="left" style="padding-left: 10px;">
		           <a href="${articleUrl}&num=${dto.commuNum}">${dto.title}</a>
		      </td>
		      <td>${dto.writer}</td>
		      <td>${dto.created}</td>
		      <td>${dto.hitCount}</td>
		      <td>
                   <c:if test="${dto.fileCount != 0}">
                        <a href="<%=cp%>/community/zipdownload?num=${dto.commuNum}"><i class="far fa-file"></i></a>
                   </c:if>		      
		      </td>
		  </tr>
		</c:forEach>
		 
		<c:forEach var="dto" items="${list}">
		  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
		      <td>${dto.listNum}</td>
		       <td>${dto.clubType}</td>
		      <td align="left" style="padding-left: 10px;">
		           <a href="${articleUrl}&num=${dto.commuNum}">${dto.title}</a>
		           <c:if test="${dto.gap < 1}">
		               <img src='<%=cp%>/resource/images/new.gif'>
		           </c:if>
		      </td>		      
		      <td>${dto.name}</td>
		      <td>${dto.created}</td>
		      <td>${dto.hitCount}</td>
		      <td>
                   <c:if test="${dto.fileCount != 0}">
                        <a href="<%=cp%>/community/zipdownload?num=${dto.commuNum}"><i class="far fa-file"></i></a>
                   </c:if>		      
		      </td>
		  </tr>
		  </c:forEach>
		</table>
		 
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
			<td align="center">
			    ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
			 </td>
		   </tr>
		</table>
		
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
		   <tr height="40">
		      <td align="left" width="100">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/community/list';">새로고침</button>
		      </td>
		      <td align="center">
		          <form name="searchForm" action="<%=cp%>/community/list" method="post">
		              <select name="condition" class="selectField">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="title" ${condition=="subject"?"selected='selected'":""}>제목</option>
		                  <option value="clubCode" ${condition=="content"?"selected='selected'":""}>동호회명</option>
		                  <option value="writer" ${condition=="userName"?"selected='selected'":""}>작성자</option>
		                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
		            </select>
		            <input type="text" name="keyword" value="${keyword}" class="boxTF">
		            <button type="button" class="btn" onclick="searchList()">검색</button>
		        </form>
		      </td>
		      <td align="right" width="100">
		        <c:if test="${sessionScope.member.userId=='admin'}">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/community/created';">글올리기</button>
		         </c:if>
		      </td>
		   </tr>
		</table>
    </div>

</div>