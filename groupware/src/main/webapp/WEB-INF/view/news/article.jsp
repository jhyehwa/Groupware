<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


<script type="text/javascript">
function deleteNews() {
	var q = "newsNum=${dto.newsNum}&${query}";
	var url = "<%=cp%>/news/delete?" + q;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")){
		  	location.href=url;
	}
}

function updateNews() {
	  var q = "newsNum=${dto.newsNum}&page=${page}";
	  var url = "<%=cp%>/news/update?" + q;

	  location.href=url;
	
</script>


	
<div class="container">
    <div class="body-container">
        <div class="body-title">
            <h3>소식 </h3>
        </div>
        
        <div class="board-article">
			<table style="margin: 20px auto 0px;">
			<tr height="35" style="background:#006461; color: white; ">
			    <td colspan="2" align="center">
				   ${dto.title}
			    </td>
			</tr>
			
			<tr height="35" style="background:#006461; color: white; ">
			    <td colspan="2" align="center">
				   ${dto.nType} 
			    </td>
			</tr>
			
			
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       작성자 : ${dto.name}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			    	${dto.created} 
			    </td>
			</tr>
			
			<tr >
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			
			
			<tr height="35" style="border-top: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글&nbsp;
					<c:if test="${not empty preReadDto}">
			              <a href="<%=cp%>/news/article?${query}&newsNum=${preReadDto.newsNum}">${preReadDto.title}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글&nbsp;
				<c:if test="${not empty nextReadDto}">
			              <a href="<%=cp%>/news/article?${query}&newsNum=${nextReadDto.newsNum}">${nextReadDto.title}</a>
			        </c:if>
			    </td>
			</tr>
			<tr height="45">
			    <td>
			          <button type="button" class="boardBtn" onclick="updateNews();">수정</button>
			          <button type="button" class="boardBtn" onclick="deleteNews();">삭제</button>
			    </td>
			
			    <td align="right">
			        <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/news/list?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
        </div>

    </div>
</div>
