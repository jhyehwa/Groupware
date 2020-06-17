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

//게시글 공감 
$(function(){
	$(".btnSendCommuLike").click(function(){
		var url = "<%=cp%>/community/insertCommuLike";
		var n = "${dto.commuNum}";
		var query = {commuNum:n};		// 객체 형태 
		
		if(! confirm("게시물에 공감하십니까?")) {
			return false;
		}
		
		var fn = function(data) {
			var state = data.state;
			if(state=="false") {
				alert("게시글의 공감은 한번만 가능합니다.");
				return;
			}
			
			var count = data.commuLikeCount; 
			$("#commuLikeCount").text(count);
		}		
		ajaxJSON(url, "post", query, fn); 
		
	});
});

//댓글 리스트, 페이징처리 
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/community/listReply";
	var query = "commuNum=${dto.commuNum}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

// 댓글 등록  (num, content, answer 서버로 전송 / userId는 session 정보 들어가있음)
$(function(){
	$(".btnSendReply").click(function(){
		var commuNum = "${dto.commuNum}";
		var $ta = $(this).closest("table").find("textarea")
		var content = $ta.val().trim();
		if(! content) {
			$ta.focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "<%=cp%>/community/insertReply";
		var query = "commuNum=" + commuNum + "&content=" + content;
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

//댓글 좋아요/싫어요 
$(function(){
	$("body").on("click", ".btnSendReplyLike", function(){
		var replyNum = $(this).attr("data-replyNum");
		var replyLike = $(this).attr("data-replyLike");
		var $btn = $(this);
		
		var msg="댓글이 마음에 들지 않으십니까?";
		if(replyLike==1) {
			msg="댓글에 공감하십니까?";
		}
		
		if(! confirm(msg)) {
			return false;
		}
		
		var url = "<%=cp%>/community/insertReplyLike";
		var query = "replyNum=" + replyNum + "&replyLike=" + replyLike;
		var fn = function(data){
			var state = data.state;
			if(state=="true") {
				var likeCount = data.likeCount;
				var disLikeCount = data.disLikeCount;
				
				$btn.parent("td").children().eq(0).find("span").html(likeCount);
				$btn.parent("td").children().eq(1).find("span").html(disLikeCount); 
			} else {
				alert("이미 공감 하셨습니다.");
			}
		};
		ajaxJSON(url, "post", query, fn);
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
		
		var url = "<%=cp%>/community/deleteReply";
		var query = "replyNum="+replyNum+"&mode=reply";
		var fn = function(data){
			listPage(page);
		};
		ajaxJSON(url, "post", query, fn);		
	});
});

// 댓글별 답글 리스트 
function listReplyAnswer(answer) {
	var url = "<%=cp%>/community/listReplyAnswer";
	var query = {answer:answer};
	var selector = "#listReplyAnswer" + answer;
	ajaxHTML(url, "get", query, selector);
}

// 댓글별 답글 개수 
function countReplyAnswer(answer) {
	var url = "<%=cp%>/community/countReplyAnswer";
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
		var commuNum = "${dto.commuNum}";
		var replyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		var content = $td.find("textarea").val().trim();
		if(! content) {
			$td.find("textarea").focus();
			return false;
		}
		content = encodeURIComponent(content);
		
		var url = "<%=cp%>/community/insertReply";		
		var query = "commuNum="+commuNum+"&content="+content+"&answer="+replyNum;		
	
		
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
		
		var url = "<%=cp%>/community/deleteReply";
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
			
			<tr style="border-bottom: 1px solid #ccc;">
				<td colspan="2" height="40" align="center" style="padding-bottom: 15px;">
					<button type="button" class="btn btnSendCommuLike" title="좋아요"><i class="fas fa-hand-point-up"></i>&nbsp;&nbsp;<span id="commuLikeCount">${dto.commuLikeCount}</span></button>
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
        <div>
		<table style="margin: 20px auto 0px;">
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
			        <button type='button' class='btn btnSendReply' style='padding:10px 20px;'>댓글 등록</button>
			    </td>
			 </tr>
		</table>  		
			<div id="listReply"></div>	
	</div>    
        </div>
    </div>
</div>


