<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/data.css" type="text/css">
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>

<div class="container">
    <div class="board-container" style="margin-left: 200px;">
        <div class="board-title" style="font-size: 18px;">
            <h3>♬ 자료실 </h3>
        </div>
        
        <div class="board-body" style="float: left; width: 20%;">
			<div style="margin-top: 20px; margin-left: 20px;">
	        		<button type="button" style="width: 220px; height: 50px; background: #9565A4; color: white; font-size: 25px; border: none; border-radius: 10px;" onclick="javascript:location.href='<%=cp%>/data/created';"><i class="fas fa-upload"></i></button>
	       	</div>	
	       	<form name="searchForm" action="" method="post">
        	<div class="selectGroup">
        		  <select class="selectBox" name="condition" class="selectField">			              
		          	   <option value="title" ${condition=="title"?"selected='selected'":""}>제목</option>
		               <option value="dataType" ${condition=="clubType"?"selected='selected'":""}>분류</option>
		               <option value="name" ${condition=="name"?"selected='selected'":""}>작성자</option>
		               <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
			      </select>        
        	</div>
        	<div style="margin-left: 20px; margin-top: -10px;">
        		<p style="font-size: 20px; border: 1px solid #cccccc; width: 220px;"><input type="text" name="keyword" class="boxTF" style="width: 170px; height: 35px; border: none; font-size: 15px; padding-left: 10px;">&nbsp;
        				<button type=button onclick="searchList()" style="border: none; background: transparent;"><i class="fas fa-search"></i></button></p>
        	</div>  
        	</form>     	
	    </div>
			
		<div class="board-body" style="width: 80%; float: left;" > 
			<div class="body-title" style="margin-top: 20px; margin-bottom: 15px;">
          		  <h3 style="font-size: 18px;">| 전체 자료실
          		  &nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		     
          		  <button type="button" style="border: none; background: transparent;" onclick="javascript:location.href='<%=cp%>/data/list';"><i class="fas fa-redo-alt"></i></button>
          		  </h3>          		 
      		  </div> 	      		        
			<table style="border-collapse: collapse;">
			  <tr align="center" bgcolor="#006461;"> 
				  <th width="60">번호</th>
			      <th width="60">분류</th>
			      <th>제목</th>
			      <th width="80">작성자</th>
			      <th width="80">작성일</th>			   
			      <th width="50">첨부</th>
			  </tr>
			 
			 <c:forEach var="dto" items="${list}">
			  <tr align="center" style="border-bottom: 1px solid #cccccc;"> 
			      <td>${dto.listNum}</td>
			      <td>${dto.dataType}</td>
			      <td align="left" style="padding-left: 10px;">
			           <a href="${articleUrl}&dataNum=${dto.dataNum}">${dto.title}(${dto.replyCount})</a>
		        	   <c:if test="${dto.gap < 1}">
		             	  
		        	   </c:if>
			      </td>
			      <td>${dto.name}</td>
			      <td>${dto.created}</td>			     
			      <td>
                   <c:if test="${dto.fileCount != 0}">
                        <a href="<%=cp%>/data/zipdownload?dataNum=${dto.dataNum}"><i class="far fa-file"></i></a>
                   </c:if>		      
		     	  </td>
			  </tr>
			 </c:forEach>

			</table>
			 
			<table style="margin-top: 10px;">
			   <tr>
				<td class="board-paging" align="center">
			        ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
				</td>
			   </tr>
			</table>
		</div>
			
			

  
    </div>
</div>
