<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.talk-container{
	width: 800px;
	align-content: center;
	margin:30px 0 0 200px;
}

.talk-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}
.more:active, .more:focus, .more:hover {
    cursor: pointer;
    color: #333333;
}
</style>

<script type="text/javascript">
var pageNo=1;
var totalPage=1;

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/talk/list";
	var query="pageNo="+page;
	
	var fn = function(data){
		printTalk(data);
	};
	
	ajaxJSON(url, "get", query, fn);		
}


$(function(){
	$(window).scroll(function(){
		if($(window).scrollTop()+50>=$(document).height()-$(window).height()) {
			if(pageNo<totalPage) {
				++pageNo;
				listPage(pageNo);
			}
		}
	});
});



function printTalk(data) {
	var uid="${sessionScope.employee.empNo}";
	var dataCount = data.dataCount;
	var page = data.pageNo;
	totalPage = data.total_page;
	
	var out="";
	if(dataCount!=0) {
		for(var idx=0; idx<data.list.length; idx++) {
			var talkNum=data.list[idx].talkNum;
			var name=data.list[idx].name;
			var writer=data.list[idx].writer;
			var content=data.list[idx].content;
			var created=data.list[idx].created;
			
			out+="    <tr height='35' bgcolor='#eeeeee'>";
			out+="      <td width='50%' style='padding-left: 5px; border:1px solid #cccccc; border-right:none;'>"+ name+"</td>";
			out+="      <td width='50%' align='right' style='padding-right: 5px; border:1px solid #cccccc; border-left:none;'>" + created;
			if(uid==writer || uid=="admin") {
				out+=" | <a onclick='deleteTalk(\""+talkNum+"\", \""+page+"\");'>삭제</a></td>" ;
			} else {
				out+=" | <a href='#'>신고</a></td>" ;
			}
			out+="    </tr>";
			out+="    <tr style='height: 50px;'>";
			out+="      <td colspan='2' style='padding: 5px;' valign='top'>"+content+"</td>";
			out+="    </tr>";
		}
		
		$("#listTalkBody").append(out);
		
		if(! checkScrollBar()) { // checkScrollBar() 함수는 util-jquery.js 에 존재
			if(pageNo<totalPage) {
				++pageNo;
				listPage(pageNo);
			}
		}
	}
}

function sendTalk() {
	if(! $.trim($("#content").val()) ) {
		$("#content").focus();
		return;
	}
	
	var url="<%=cp%>/talk/insert";
	var query=$("form[name=talkForm]").serialize();
	
	var fn = function(data){
		$("#content").val("");
		
		$("#listTalkBody").empty();
		pageNo=1;
		listPage(1);
	};
	
	ajaxJSON(url, "post", query, fn);
}

function deleteTalk(talkNum, page) {
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/talk/delete";
		var query="talkNum="+talkNum;
		
		var fn = function(data){
			// var state=data.state;
			$("#listTalkBody").empty();
			pageNo=1;
			listPage(1);
		};
		
		ajaxJSON(url, "post", query, fn);
	}
}

</script>



<div class="container">
	<div class="talk-container" >
	    <div class="body-title">
	        <h3><i class="far fa-edit"></i> 오늘의한마디이이^_^ </h3>
	    </div>
    
    	<div>
           <form name="talkForm" method="post" action="">
           	 <div class="talk-write">
                 <div>
                       <span style="font-weight: bold;">오늘의한마디쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
                 </div>
                 <div style="padding-top: 10px;">
                       <textarea name="content" id="content" class="boxTF" rows="3" style="display:block; width: 100%; padding: 6px 12px; box-sizing:border-box;" required="required"></textarea>
                  </div>
                  <div style="text-align: right; padding-top: 10px;">
                       <button type="button" class="btn" onclick="sendTalk();" style="padding:8px 25px;"> 등록하기 </button>
                  </div>           
          	 </div>
           </form>
           <div id="listTalk">
           	 <table style='width: 100%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;'>
	           <thead>
		           <tr height='35'>
		                <td width='50%'>
		                    <span style='color: #3EA9CD; font-weight: 700;'>방명록</span>
		                    <span>[목록]</span>
		                 </td>
		                 <td width='50%'>&nbsp;</td>
		           </tr>
	           </thead>
	           <tbody id="listTalkBody"></tbody>
	         </table>
           </div>                
 	 </div>
 	 
	</div>   
</div>