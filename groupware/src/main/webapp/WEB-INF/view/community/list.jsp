<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/community.css" type="text/css">

<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
</script>

<div class="container">
    <div class="board-container">
        <div class="body-title" style="font-size: 18px;">
            <h3> ♬ 커뮤니티 </h3>
        </div>
        
        <div class="board-body" style="float: left; width: 20%;">
        	<div style="margin-top: 20px; margin-left: 20px;">
        		<button type="button" style="width: 220px; height: 50px; background: #6E3C89; color: white; font-size: 20px; border: none; border-radius: 10px;" onclick="javascript:location.href='<%=cp%>/community/created';">글올리기</button>
        	</div>
            <form name="searchForm" action="" method="post">
        	<div class="selectGroup">
        		  <select class="selectBox" name="condition" class="selectField">			              
		          	  <option value="title" ${condition=="title"?"selected='selected'":""}>제목</option>
		          	  <option value="clubType" ${condition=="clubType"?"selected='selected'":""}>동호회명</option>
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
        
        
        <div class="board-body" style="width: 40%; float: left;">        
        	  <div class="body-title" style="margin-top: 20px; margin-bottom: 15px;">
          		  <h3 style="font-size: 18px;">| 최신글 <i class="fas fa-file-signature"></i></h3>          		 
      		  </div> 	

			<c:forEach var="dto" items="${list}">
				<table style="border-collapse: collapse; margin-bottom: 20px; width: 100%; border-bottom: 1px solid #cccccc; border-top: 1px solid #cccccc;">		 
					  <tr align="left"> 		
					      <td width="80%;" style="color: gray; font-weight: bold; font-size: 14px;">&nbsp;&nbsp;[${dto.clubType}]</td>
					      <td>&nbsp;</td>				   
					  </tr>
					  <tr align="left">
					      <td align="left" style="padding-left: 10px; font-weight: bold; font-size: 16px;">
					           <a style=" color: #041910;" href="${articleUrl}&commuNum=${dto.commuNum}">${dto.title}</a>
					            <c:if test="${dto.gap < 1}">
		             	  			<img src='<%=cp%>/resource/images/new.png'>
		        	  		    </c:if>
				          </td>	
				          <td>&nbsp;</td>	      
				      </tr>
				      <tr align="left">
					      <td style="color: #5a5a5a;">&nbsp;&nbsp;${dto.name}</td>	
					      <td style="color: #5a5a5a;">${dto.created}</td>	
					  </tr>
				</table>
			 </c:forEach>
			 
			<table style="margin: 10px 0 0 100px; width: 50%;">
			   <tr>
				<td class="board-paging" align="center">
			        ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
				</td>
			   </tr>
			</table>
			
			<table style="margin-top: 10px; width: 100%;">
			   <tr height="40">
			      <td align="left" width="100">
			          <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/community/list';">새로고침</button>
			      </td>
			      <td align="center">
			      </td>			   
			   </tr>
			</table>
        </div>   
        
        <div class="board-body" style="width: 30%; float: left; margin-left: 20px;"> 
        	<div class="body-title" style="margin-top: 20px; margin-bottom: 15px;">
          		  <h3 style="font-size: 18px;">| 커뮤니티 정보 <i class="fas fa-file-signature"></i></h3>          		 
      	    </div> 
        </div>
        
          
    </div>
</div>
