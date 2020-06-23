<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
function deleteData() {
	var q = "dataNum=${dto.dataNum}&${query}";
	var url = "<%=cp%>/data/delete?" + q;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")){
		  	location.href=url;
	}
}

function updateData() {
	  var q = "dataNum=${dto.dataNum}&page=${page}";
	  var url = "<%=cp%>/data/update?" + q;

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
	});	
}


//댓글 리스트, 페이징처리 
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/data/listReply";
	var query = "dataNum=${dto.dataNum}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

// 댓글 등록  (num, content, answer 서버로 전송 / userId는 session 정보 들어가있음)
$(function(){
	$(".btnSendReply").click(function(){
		var dataNum = "${dto.dataNum}";
		var $ta = $(this).closest("table").find("textarea")
		var content = $ta.val().trim();
		if(! content) {
			$ta.focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "<%=cp%>/data/insertReply";
		var query = "dataNum=" + dataNum + "&content=" + content;
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
		
		var url = "<%=cp%>/data/deleteReply";
		var query = "replyNum="+replyNum+"&mode=reply";
		var fn = function(data){
			listPage(page);
		};
		ajaxJSON(url, "post", query, fn);		
	});
});

// 댓글별 답글 리스트 
function listReplyAnswer(answer) {
	var url = "<%=cp%>/data/listReplyAnswer";
	var query = {answer:answer};
	var selector = "#listReplyAnswer" + answer;
	ajaxHTML(url, "get", query, selector);
}

// 댓글별 답글 개수 
function countReplyAnswer(answer) {
	var url = "<%=cp%>/data/countReplyAnswer";
	var query = {answer:answer};
	
	var fn = function(data) {
		var count = data.count;
		var selector = "#answerCount" + answer;
		$(selector).text(count); 
	};
	ajaxJSON(url, "post", query, fn);
}

// 답글 버튼 : 댓글별 답글 폼, 댓글별 답글 리스트 출력 
$(function(){
	$("body").on("click", ".btnReplyAnswerLayout", function(){		// on : 동적으로 추가된 객체의 이벤트 처리
		var $trAnswer = $(this).closest("tr").next();
		var isVisible = $trAnswer.is(":visible");
		var replyNum = $(this).attr("data-replyNum");
		
		if(isVisible) {
			$trAnswer.hide();
		} else {
			$trAnswer.show();
			
			// 답글 리스트 
			listReplyAnswer(replyNum);		
			
			// 답글 개수 
			countReplyAnswer(replyNum);
		}
		
	});
});

// 댓글별 답글 등록 
$(function(){
	$("body").on("click", ".btnSendReplyAnswer", function(){
		var dataNum = "${dto.dataNum}";
		var replyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		var content = $td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "<%=cp%>/data/insertReply";		
		var query = "dataNum="+dataNum+"&content="+content+"&answer="+replyNum;		
	
		
		var fn = function(data) {
			$td.find("textarea").val("");
			
			var state = data.state;
			if(state=="true") {
				// 댓글의 답글 리스트
				listReplyAnswer(replyNum);
				
				// 댓글의 답글 개수 
				countReplyAnswer(replyNum);
			}
		}
		
		ajaxJSON(url, "post", query, fn);
		 
	});
});

// 답글 삭제 
$(function(){
	$("body").on("click", ".deleteReplyAnswer", function(){
		if(! confirm("댓글을 삭제 하시겠습니까?")) {
			return false;
		}
		
		var replyNum = $(this).attr("data-replyNum");
		var answer = $(this).attr("data-answer");
		
		var url = "<%=cp%>/data/deleteReply";
		var query = "replyNum=" + replyNum + "&mode=answer";
		
		var fn = function(data) {
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		ajaxJSON(url, "post", query, fn);
	});
});

</script>
</head>
<body>

	
<div class="container">
    <div class="board-container">
        <div class="board-title">
            <h3>♬ 자료실 </h3>
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
			        ${dto.created} 
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
				     첨부 된 파일 :  <a href="<%=cp%>/data/download?fileNum=${vo.fileNum}">${vo.originalFilename} </a>	
				     (<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)		       
				    </td>
				</tr>
			</c:forEach>
			
			<tr height="35" style="border-top: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
					<c:if test="${not empty preReadDto}">
			              <a href="<%=cp%>/data/article?${query}&dataNum=${preReadDto.dataNum}">${preReadDto.title}</a>
			        </c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
					 <c:if test="${not empty nextReadDto}">
			              <a href="<%=cp%>/data/article?${query}&dataNum=${nextReadDto.dataNum}">${nextReadDto.title}</a>
			        </c:if>
			    </td>
			</tr>
			<tr height="45">
			    <td>
			          <button type="button" class="boardBtn" onclick="updateData();">수정</button>
			          <button type="button" class="boardBtn" onclick="deleteData();">삭제</button>
			    </td>
			
			    <td align="right">
			        <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/data/list';">리스트</button>
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


