<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
function deleteCommu() {
	var q = "commuNum=${dto.commuNum}&${query}";
	var url = "<%=cp%>/community/delete?" + q;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")){
		  	location.href=url;
	}
}

function updateCommu() {
	  var q = "commuNum=${dto.commuNum}&page=${page}";
	  var url = "<%=cp%>/community/update?" + q;

	  location.href=url;
}
</script>
</head>
<body>

	
<div class="container">
    <div class="body-container">
        <div class="body-title">
            <h3>♬ 커뮤니티 </h3>
        </div>
        
        <div class="board-article">
			<table style="margin: 20px auto 0px;">
			<tr height="35" style="background:#006461; color: white; ">
			    <td colspan="2" align="center">
				    ${dto.title}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       작성자 : ${dto.name}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        ${dto.created} | 조회 ${dto.hitCount}
			    </td>
			</tr>
			
			<tr >
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			
			<c:forEach var="vo" items="${listFile}">
				<tr height="35" style="border-bottom: 1px solid #cccccc;">
				    <td colspan="2" align="left" style="padding-left: 5px;">
				     첨부 된 파일 :  <a href="<%=cp%>/community/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>			       
				    </td>
				</tr>
			</c:forEach>
			
			<tr height="35" style="border-top: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
					<c:if test="${not empty preReadDto}">
			              <a href="<%=cp%>/community/article?${query}&commuNum=${preReadDto.commuNum}">${preReadDto.title}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
					 <c:if test="${not empty nextReadDto}">
			              <a href="<%=cp%>/community/article?${query}&commuNum=${nextReadDto.commuNum}">${nextReadDto.title}</a>
			        </c:if>
			    </td>
			</tr>
			<tr height="45">
			    <td>
			          <button type="button" class="boardBtn" onclick="updateCommu();">수정</button>
			          <button type="button" class="boardBtn" onclick="deleteCommu();">삭제</button>
			    </td>
			
			    <td align="right">
			        <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/community/list';">리스트</button>
			    </td>
			</tr>
			</table>
        </div>

    </div>
</div>


