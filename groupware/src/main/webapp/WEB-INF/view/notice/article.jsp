<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


<script type="text/javascript">
function deleteNotice() {
	var q = "noticeNum=${dto.noticeNum}&${query}";
	var url = "<%=cp%>/notice/delete?" + q;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")){
		  	location.href=url;
	}
}

function updateNotice() {
	  var q = "noticeNum=${dto.noticeNum}&page=${page}";
	  var url = "<%=cp%>/notice/update?" + q;

	  location.href=url;
}

function ajaxJSON(url, method, query, fn) {
	$.ajax({
		type: method, 
		url: url,
		data: query,
		dataType: "json",
		success: function(data){
			fn(data);
		}, 
		beforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		}, 
		error: function(jqXHR) {
			if(jqXHR.state==403) {		// 로그인이 안됐으면 
				login(); 
				return false;
			} 			
			console.log(jqXHR.responseText);
		}
	});
}

function ajaxHTML(url, method, query, selector) {
	$.ajax({
		type: method, 
		url: url,
		data: query,
		success: function(data){
			$(selector).html(data);
		}, 
		beforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		}, 
		error: function(jqXHR) {
			if(jqXHR.state==403) {		
				login(); 
				return false;
			} 			
			console.log(jqXHR.responseText);
		}
	});		}

//댓글 리스트, 페이징처리 
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/notice/listReply";
	var query = "noticeNum=${dto.noticeNum}&pageNo="+page;
	var selector = "#listReply";
			
	ajaxHTML(url, "get", query, selector);
}

// 댓글 등록  (num, content, answer 서버로 전송 / userId는 session 정보 들어가있음)
$(function(){
	$(".btnSendReply").click(function(){
		var noticeNum = "${dto.noticeNum}";
		var $ta = $(this).closest("table").find("textarea")
		var content = $ta.val().trim();
		if(! content) {
			$ta.focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "<%=cp%>/notice/insertReply";
		var query = "noticeNum=" + noticeNum + "&content=" + content;
		var fn = function(data) {
			var state = data.state;
			if(state=="false") {
				alert("댓글을 추가하지 못했습니다.");
				return false;
			}
					
			$ta.val("");
			listPage(1);
		}
				
		ajaxJSON(url, "post", query, fn)
	});
});


		// 댓글 삭제 
$(function(){
	$("body").on("click", ".deleteReply", function(){
		if(! confirm("댓글을 삭제 하시겠습니까?")) {
			return false;
		}
		var replyNum = $(this).attr("data-replyNum");
		var page = $(this).attr("data-pageNo");
		
		var url = "<%=cp%>/notice/deleteReply";
		var query = "replyNum="+replyNum;
		var fn = function(data){
			listPage(page);
		};
		ajaxJSON(url, "post", query, fn);		
	});
});
	
</script>


	
<div class="container">
    <div class="board-container">
        <div class="board-title">
            <h3>공지사항 </h3>
        </div>
        
        <div class="board-article">
			<table>
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
				<tr height="35">
				    <td colspan="2" align="left" style="padding-left: 5px;">
				             첨부파일 :
				      <a href="<%=cp%>/notice/download?fileNum=${vo.fileNum}">${vo.originalFilename}</a>
				    </td>
				</tr>
			</c:forEach>
			
			<tr height="35" style="border-top: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글&nbsp;
					<c:if test="${not empty preReadDto}">
			              <a href="<%=cp%>/notice/article?${query}&noticeNum=${preReadDto.noticeNum}">${preReadDto.title}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글&nbsp;
				<c:if test="${not empty nextReadDto}">
			              <a href="<%=cp%>/notice/article?${query}&noticeNum=${nextReadDto.noticeNum}">${nextReadDto.title}</a>
			        </c:if>
			    </td>
			</tr>
			<tr height="45">
			    <td>
			          <button type="button" class="boardBtn" onclick="updateNotice();">수정</button>
			          <button type="button" class="boardBtn" onclick="deleteNotice();">삭제</button>
			    </td>
			
			    <td align="right">
			        <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/notice/list?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
		<div>
			<table style="margin-top: 20px">
				<tr height='30'> 
					 <td align='left' >
				 		<span style='font-weight: bold;'>댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
				 	</td>
				</tr>
				<tr>
			   		<td style='padding:5px 5px 0px;'>
						<textarea class='boxTA' style='width:99%; height: 70px;'></textarea>
			   		</td>
				</tr>
				<tr>
			   		<td align='right'>
			        	<button type='button' class='boardBtn btnSendReply' style='padding:5px 5px; margin-right: 10px;'>댓글 등록</button>
			   		</td>
				 </tr>
			</table>  		
			<div id="listReply"></div>	
		</div>    
        </div>

    </div>
</div>
