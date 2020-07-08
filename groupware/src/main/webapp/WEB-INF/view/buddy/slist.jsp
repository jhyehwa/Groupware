﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.tablesorter.min.js"></script>
<link rel="stylesheet" href="<%=cp%>/resource/css/data.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/buddy.css" type="text/css">

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>

<script type="text/javascript">
  $(document).ready(function() {
    $("#buddyTable").tablesorter();
  });
</script>

<script type="text/javascript">
$(function() {
	$("#chkAll").click(function() {
		if($(this).is(":checked")) {
			$("input[name=buddyNums]").prop("checked", true);
		} else {
			$("input[name=buddyNums]").prop("checked", false);
		}
	});
	
	$("#btnDeleteList").click(function(){
		var cnt = $("input[name=buddyNums]:checked").length;
		
		if(cnt == 0) {
			alert("삭제 할 메일을 선택 하세요.");
			return false;
		}
		
		if(confirm("선택한 메일을 삭제 하시겠습니까?")) {
			var f = document.sbuddyListForm;
			f.action = "<%=cp%>/buddy/deleteList";
			f.submit();
		}
	});
});
</script>

<script type="text/javascript">
function ajaxHTML(url, method, query, selector) {
	$.ajax({
		type: method, 
		url: url,
		data: query,
		success: function(data){
			$(selector).html(data);
		}, 
		error: function(jqXHR) {
			if(jqXHR.state==403) {		
				login(); 
				return false;
			} 			
			console.log(jqXHR.responseText);
		}
	});	
}

$("body").on("click", ".aTag", function(){
 	var buddyNum = $(this).closest("td").find("input[type=hidden]").val(); 
	var page = $("input[name=page]").val();
	
	var url = "<%=cp%>/buddy/mail";
	var query = "page="+page+"&buddyNum="+buddyNum;
	
	ajaxHTML(url, "GET", query, ".mailArticle");
});
</script>


<div class="container">
    <div class="board-container" style="margin-left: 200px;">
        <div class="board-title" style="font-size: 18px;">
            <h3>♬ 메일 </h3>
        </div>
        
        <div class="board-body" style="float: left; width: 20%;">
			<div style="margin-top: 20px; margin-left: 20px;">
	        		<button type="button" style="width: 220px; height: 50px; background: #9565A4; color: white; font-size: 25px; border: none; border-radius: 10px;" onclick="javascript:location.href='<%=cp%>/buddy/created';"><i class="fas fa-pen"></i>  </button>
	       	</div>	
	       	<div style="margin-top: 5px; margin-left: 20px;">
	       		    <button type="button" style="width: 107px; margin-right: 2px; height: 38px; background: #9565A4; color: white; font-size: 18px; border: none; border-radius: 10px;" onclick="javascript:location.href='<%=cp%>/buddy/rlist';">
	       		    			&nbsp;&nbsp;<span><i class="fas fa-archive"></i></span>
	       		    			<span style="font-size: 13px; font-weight: bold;">${unreadCount==0? "": unreadCount}</span>
	       		    </button>
	       	        <button type="button" style="width: 107px; height: 38px; background: #9565A4; color: white; font-size: 18px; border: none; border-radius: 10px;" onclick="javascript:location.href='<%=cp%>/buddy/keep';"><i class="fas fa-star"></i></button>
	       	</div>
	      	       	
	       	<form name="searchForm" action="" method="post">
        	<div class="selectGroup">
        		  <select class="selectBox" name="condition" class="selectField">			              
		          	   <option value="title" ${condition=="title"?"selected='selected'":""}>제목</option>
		               <option value="content" ${condition=="clubType"?"selected='selected'":""}>내용</option>
		               <option value="name" ${condition=="name"?"selected='selected'":""}>이름</option>
			      </select>        
        	</div>
        	<div style="margin-left: 20px; margin-top: -10px;">
        		<p style="font-size: 20px; border: 1px solid #cccccc; width: 220px;"><input type="text" name="keyword" class="boxTF" style="width: 170px; height: 35px; border: none; font-size: 15px; padding-left: 10px;">&nbsp;
        				<button type=button onclick="searchList()" style="border: none; background: transparent;"><i class="fas fa-search"></i></button></p>
        	</div>  
           	</form>     	
	    </div>
			
			
			
			
		<div class="board-body" style="width: 58%; float: left;" > 
			<div class="body-title" style="margin-top: 20px; margin-bottom: 15px;">
          		  <h3 style="font-size: 18px;">| 보낸 메일함
          		  &nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          		  
          		  <button type="button" id="btnDeleteList" style="border:none; background: none; font-size: 20px; margin-bottom: 7px; margin-left: 5px; color: #353535;"> <i class="far fa-trash-alt"></i></button>   
          		  &nbsp;
          		  <button type="button" style="border: none; background: transparent;" onclick="javascript:location.href='<%=cp%>/buddy/slist';"><i class="fas fa-redo-alt"></i></button>
          		  </h3>          		 
      		  </div> 	
      		  
      		  
      		        	
      		<form method="post" name="sbuddyListForm">	        
			<table id="buddyTable" class="tablesorter" style="border-collapse: collapse; border-bottom: 1px solid #cccccc;  width: 810px;">
				<thead>				 
				  <tr align="center" style="border-bottom: 1px solid #cccccc; border-top: 1px solid #cccccc; font-size: 14px; font-weight: bold; color: #424242;">		
				  	  <td width="35px;"> <input type="checkbox" name="chkAll" id="chkAll" value="all" ></td>  	
				  	  <td width="35px;"><i class="far fa-envelope"></i></td>		  
				      <td width="70px;">수신부서 <span style="font-size: 11px;"> <i class="fas fa-sort"></i> </span></td>	  
				      <td width="100px;">수신인 <span style="font-size: 11px;"> <i class="fas fa-sort"></i> </span></td>
				      <td width="330px;">제목 <span style="font-size: 11px;"> <i class="fas fa-sort"></i> </span></td>	
				      <td width="50px;">첨부 <span style="font-size: 11px;"> <i class="fas fa-sort"></i> </span> </td>		      
				      <td>발신 날짜 <span style="font-size: 11px;"> <i class="fas fa-sort"></i> </span> </td>			   
				  </tr>
				</thead>
				
			 <tbody>
			 <c:forEach var="dto" items="${slist}">
			  <tr align="center" style="border-bottom: 1px solid #E6E6E6;"> 
			  	  <td><input type="checkbox" name="buddyNums" value="${dto.buddyNum}"></td>	
			  	<c:if test="${dto.buddyCheck==0}">
			  	  <td> <i class="far fa-envelope"></i> </td>
			  	</c:if>	
			  	<c:if test="${dto.buddyCheck!=0}">
			  	  <td> <i class="fas fa-envelope-open"></i> </td>
			  	</c:if>	
			  	  <td align="left" style="padding-left: 5px;"> ${dto.dType} </td>
			      <td align="left" style="padding-left: 15px;">${dto.name}${dto.pType}</td>
			      <td align="left" style="padding-left: 10px;">
			           <a href="${articleUrl}&buddyNum=${dto.buddyNum}&empNo=${dto.empNo}">${dto.title}</a>
			           <a class="aTag" href="#"> <i class="fas fa-external-link-alt" style="font-size: 10px;"></i> </a>
			           <input type="hidden" value="${dto.buddyNum}">
			      </td>			   
			      <td>
			      	<c:if test="${dto.fileCount != 0}">
			      		 <a href="<%=cp%>/buddy/zipdownload?buddyNum=${dto.buddyNum}"><i class="fas fa-save"></i></a>
			      	</c:if>
			      	<c:if test="${dto.fileCount == 0}">
			      		-
			      	</c:if>
			      </td>   
			      <td>${dto.sDate}</td>	    
			  </tr>
			 </c:forEach>
			 </tbody>
			</table>	
			 <input type="hidden" name="page" value="${page}">				
			</form>			
			 
			<table style="margin-top: 10px;">
			   <tr>
				<td colspan="8" id="list-paging">${dataCount == 0 ? "받은 메일이 없습니다." : paging}</td>
			   </tr>
			</table>
		</div>
		
		
		<div class="board-body" style="width: 22%; float: left; margin-left: -18px;" > 
			<div class="body-title" style="margin-top: 20px; margin-bottom: 15px;">
          		  <div class="mailArticle" id="mailArticle"></div>				  		 
            </div>
		</div>		
		  
    </div>
</div>
