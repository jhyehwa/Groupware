<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/sign.css" type="text/css">
<script type="text/javascript"	src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript"	src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
<style>
.board-bodys{
	width: 800px;
}

.signList {
	color: #cccccc;
}

.signList:hover{
	color: black;
}

</style>
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
	
	function ajaxHTML(url, type, query, selector) {
		$.ajax({
			type:type,
			url:url,
			data:query,
			success:function(data){
				$(selector).html(data);
			},
			error:function(e){
				console.log(e.responseText);
			}
		});
	}
	

	function ajaxJSON(url, type, query, fn) {
		$.ajax({
			type:type
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				fn(data);
			}
			/* , beforeSend:function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    } */
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
		$("body").on("click", ".articleSign", function(){
			var option = $(this).closest("tr").find("input[class=dtoStnum]").val();
			var valueSnum = $(this).closest("tr").find("input[class=dtoSnum]").val();
			var listVal = "${mode}";
			
			$("#articleModal-dialog").dialog({
				modal : true,
				width : 1050,
				height : 1100,
				position : {my:"center top", at:"center top"},
				show : "fade",
				resizable : false,
				title : '결재',
				open : function() {
					
					$(".showSing").show();
					
					var url = "<%=cp%>/sign/search";
					
					if(option==0){
						return;
					}
					
					var query = "option="+ option+ "&mode=article"+"&valueSnum="+valueSnum+"&listVal="+listVal;
					
					ajaxHTML(url, "GET", query, ".showSing");
				
					
				},
				close : function(event, ui) {
						
				}
			});
		});
		
	});
	
	
	$(function(){
		$("body").on("click", ".choiceBtn", function(){
			var val = $(this).val();
			var sNum = $(this).closest("form").find("input[class=hiddenSnum]").val();
			
			var url = "<%=cp%>/sign/passSign";
			
			if(val == "ok"){
				var result = confirm("승인하시겠습니까?");
				
				if(result){
					var query = "passVal="+val+"&sNum="+sNum;
					ajaxHTML(url, "GET", query,"");
					
					location.reload();					
				}
			}else if(val == "no"){
				$(".returnMemoDiv").show();
				
				$("body").on("click", ".returnMemo", function(){
					var writer = $(this).closest("div").find("input[type=hidden]").val();
					var returnMemo = $(this).closest("div").find("textarea").val();
					
					var query = "passVal="+val+"&sNum="+sNum+"&writer="+writer+"&returnMemo="+returnMemo;
					var fn = function(data){
						location.href="<%=cp%>/sign/list?mode="+${option};
					}
					ajaxJSON(url, "GET", query, fn);
				});
			}
		});
	});
	
	

	function check() {
		var f = document.inputForm;
		var hiddenSnum = $("input[class=hiddenSnum]").val();
		var option = $("input[class=option]").val();
		
		var pempNo2 = $("input[id=pempNo2]").val();
		var pempNo3 = $("input[id=pempNo3]").val();
		var pempNo4 = $("input[id=pempNo4]").val();
		
		var str = f.ssubject.value;
		if(!str){
			alert("제목을 입력하세요.");
			f.ssubject.focus();
			return false;
		}
		
		str = f.scontent.value;
		if(!str || str == "<p>&nbsp;</p>"){
			alert("내용을 입력하세요.");
			f.scontent.focus();
			return false;
		}
		
		
		storage = f.sStorage.value;
		
		var chk =  $("input:checkbox[id='sStorage']").is(":checked");
		
		if(chk){
			f.action = "<%=cp%>/sign/storage?option="+option+"&storage="+storage;
			f.submit();
			return;
		}
		
		if(! chk){
			f.action = "<%=cp%>/sign/created?option="+option+"&hiddenSnum="+hiddenSnum+"&pempNo2="+pempNo2+"&pempNo3="+pempNo3+"&pempNo4="+pempNo4+"&article=article";
			f.submit();
			return;
		}
	}
	
</script>

<div class="container">
	<div class="board-container">
       <div class="body-title" style="height: 50px;">
				<span style="font-size: 20px; font-family: '맑은고딕'; font-weight: 900;">${mode}</span>
		</div>
		
		<div class="board-body" style="float: left; width: 20%">
			<div>
				<button type="button" class="btnSend" style="width: 98px; height: 50px; border-radius: 10px; border: none; background: #9565A4;" onclick="javascript:location.href='<%=cp%>/sign/created';">
					<i class="fas fa-paste" style="color: white; font-size: 18px;">&nbsp;</i><i class="fas fa-plus" style="color: white; font-size: 18px;"></i>
				</button>
				<button type="button" class="boardBtn"style="width: 98px; height: 50px; border-radius: 10px; border: none; background: #9565A4;"  onclick="javascript:location.href='<%=cp%>/sign/mainList';">
					<i class="far fa-arrow-alt-circle-left" style="color: white; font-size: 18px; font-weight: bold">&nbsp;back</i>
				</button>
			</div>
		</div>
		
        
        <div class="board-body">
			<div class="board-body" style="float: left; width: 58%;">
				<table style="margin-top: 20px; width: 800px;">
			   <tr>
			      <td align="left">
			          &nbsp;
			      </td>
			   </tr>
			</table>
			
			<table class="trData" style="border-collapse: collapse; width: 800px;">
			  <tr align="center" bgcolor="#006461;"> 
			      <th width="70">부서</th>
				  <th width="80">기안자</th>
			      <th width="60">종류</th>
			      <th>제목</th>
			      <th width="80">기안일</th>
			      <th width="60">상태</th>
			  </tr>
			<c:forEach var="dto" items="${list}">
			  <tr align="center" style="border-bottom: 1px solid #cccccc;">
			      <td>${dto.dType} 
			      <input type="hidden" class="dtoSnum" value="${dto.snum}"></td>
				  <td>${dto.name}&nbsp;${dto.pType}</td>
			      <td class="stNum">
			      <c:choose>
			      	<c:when test="${dto.stnum == 1}">기안</c:when>
			      	<c:when test="${dto.stnum == 2}">휴가</c:when>
			      </c:choose>
			      	<input type="hidden" class="dtoStnum" value="${dto.stnum}"></td>
			      <td align="left" style="padding-left: 40px;" class="ssubject">
			           <a class="articleSign">${dto.ssubject}</a>
			      </td>
			      <td>${dto.sdate}</td>
			      <td>${dto.scurrStep!=dto.sendStep?'미결':'완료'}</td>
			  </tr>
			</c:forEach>
			</table>
			 
			<table style="width: 800px;">
			   <tr>
				<td class="board-paging" align="center">
			         ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
				</td>
			   </tr>
			</table>
			</div>
        </div>
        
        <div class="board-body" style="float: left;">
				<table style="width: 100%; border: 1px solid #cccccc; border-bottom: none; width: 300px;">
								<tr align="left">
									<td style="padding-left: 12px; color: #505050; border-bottom: 1px solid #cccccc; font-weight: bold; font-size: 16px; ">
									<i class="fas fa-arrow-right"></i>
										<a class="signList" href="javascript:location.href='<%=cp%>/sign/list?mode=1'"> 결재대기함 </a>
									</td>
								</tr>
								<tr align="left">
									<td style="padding-left: 12px; color: #505050; border-bottom: 1px solid #cccccc; font-weight: bold; font-size: 16px; ">
									<i class="fas fa-arrow-right"></i>
										<a class="signList" href="javascript:location.href='<%=cp%>/sign/list?mode=2'" > 수신대기함 </a>
									</td>
								</tr>
								<tr align="left">
									<td style="padding-left: 12px; color: #505050; border-bottom: 1px solid #cccccc; font-weight: bold; font-size: 16px; ">
									<i class="fas fa-arrow-right"></i>
										<a class="signList" href="javascript:location.href='<%=cp%>/sign/list?mode=3'"> 결재완료함 </a>
									</td>
								</tr>
								<tr align="left">
									<td style="padding-left: 12px; color: #505050; border-bottom: 1px solid #cccccc; font-weight: bold; font-size: 16px; ">
									<i class="fas fa-arrow-right"></i>
										<a class="signList" href="javascript:location.href='<%=cp%>/sign/list?mode=4'"> 반려함 </a>
									</td>
								</tr>
								<tr align="left">
									<td style="padding-left: 12px; color: #505050; border-bottom: 1px solid #cccccc; font-weight: bold; font-size: 16px; ">
									<i class="fas fa-arrow-right"></i>
										<a class="signList" href="javascript:location.href='<%=cp%>/sign/list?mode=6'"> 임시보관함 </a>
									</td>
								</tr>
							</table>
						</div>
						</div>
        
        
    </div>



<!-- 아티클 모달 -->
<div id="articleModal-dialog" class="articleModal">
	<div class="showSing"  style="  width: 1000px; height:1000px; position:absolute; display: none; border: 1px solid black;">
	</div>
</div>

