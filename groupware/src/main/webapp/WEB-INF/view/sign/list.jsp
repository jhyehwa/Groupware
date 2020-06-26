<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style type="text/css">
.buttonDiv{
	padding-top:25px;
	height: 30px;
	width: 1000px;
}


.selectGroup {
	height: 39px;
	position: relative;
	padding-top: 13px;
/* 	background: orange; */
}

.selectGroup .selectBox {
	margin-top: 9px;	
	width: 110px;
	height: 25px;
	position: absolute;
	top: 0;
	z-index: 1;
	border: none;
	background: transparent;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	cursor: pointer;
	padding-left: 5px;
	font-size: 15px;
}

.selectGroup:before {
	content: '';
	position: absolute;
	width: 80px;
	height: 25px;
	z-index: 0;
	margin-top: -5px;
	-webkit-border-radius: 0px 0px 0px 0px/0px 0px 0px 0px;
	-moz-border-radius: 0px 0px 0px 0px/0px 0px 0px 0px;
	border-radius: 0px 0px 0px 0px/0px 0px 0px 0px;
	background-color: white;
	-webkit-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	-moz-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	border: solid 1px #cbc9c9;
}

.selectGroup:after {
	content: '';
	position: absolute;
	right: 110px;
	width: 30px;
	height: 26px;
 	background-color: #6E3C89;
	background-image: url(https://raw.githubusercontent.com/solodev/styling-select-boxes/master/select1.png);
	background-position: center;
	background-repeat: no-repeat;
	z-index: 0;
	margin-top: -5px;
	-webkit-border-radius: 0px 0px 0px 0px/0px 0px 0px 0px;
	-moz-border-radius: 0px 0px 0px 0px/0px 0px 0px 0px;
	border-radius: 0px 0px 0px 0px/0px 0px 0px 0px;
	-webkit-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	-moz-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	border: solid 1px #cbc9c9;
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
	
	$(function(){
		$("body").on("click", ".articleSign", function(){
			var option = $(this).closest("tr").find(".stNum").text();
			var valueSnum = $(this).closest("tr").find("input[class=dtoSnum]").val();
			
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
					
					var query = "option="+ option+ "&mode=article"+"&valueSnum="+valueSnum;
					
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
					var query = "passVal="+val+"&sNum="+sNum;
					ajaxHTML(url, "GET", query,"");
					location.reload();
				});
			}
		});
	});
	
</script>

<!-- 아티클 모달 -->
<div id="articleModal-dialog" class="articleModal">
	<div class="showSing"  style="  width: 1000px; height:950px; position:absolute; display: none; border: 1px solid black;">
	</div>
</div>

<div class="container">
        <div class="body-title" style="margin : 40px 0px 0px 300px;">
				<span style="font-size: 20px; font-family: '맑은고딕'; font-weight: 900;"> ${mode}</span>
		</div>
		
		<div style="float: left; margin-left:130px; margin-top: 40px;">
				<button type="button" class="btnSend" style="width: 200px; height: 50px; border-radius: 10px; border: none; background: #9565A4;" onclick="javascript:location.href='<%=cp%>/sign/created';">
					<i class="fas fa-paste" style="color: white; font-size: 18px;">&nbsp;새결재진행 &nbsp;</i><i class="fas fa-plus"  style="color: white; font-size: 18px;"></i>
				</button>
						
		<form name="searchForm" action="<%=cp%>/sign/list?mode=5" method="post">
        	<div class="selectGroup">
        		  <select class="selectBox" id="condition" name="condition" class="selectField">			              
		          	  <option value="emptyVal" ${condition=="emptyVal"?"selected='selected'":""}>::선택::</option>
		          	  <option value="title" ${condition=="title"?"selected='selected'":""}>제목</option>
		          	  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		           	  <option value="created" ${condition=="created"?"selected='selected'":""}>기안일</option>
			      </select>  
        	</div>
        	<div style="margin-top: -10px;">
        		<p style="font-size: 20px; border: 1px solid #cccccc; width: 220px;">
        		<input type="text" id="keyword" name="keyword" class="boxTF" style="width: 170px; height: 35px; border: none; font-size: 15px; padding-left: 10px;">&nbsp;
        				<button type=button onclick="searchList();" style="border: none; background: transparent;"><i class="fas fa-search"></i></button></p>
        	</div>   
        	</form>
		</div>
		
    <div class="board-container">
        
        <div class="board-body">
			<table style="margin-top: 20px; margin: 9px 0px 0px 223px; width: 1000px;">
			   <tr>
			      <td align="left">
			          &nbsp;
			      </td>
			      <td class="dataCount" align="right">
			          ${dataCount}개(${page}/${total_page} 페이지)
			      </td>
			   </tr>
			</table>
			
			<table class="trData" style="border-collapse: collapse; margin: 9px 0px 0px 223px; width: 1000px;">
			  <tr align="center" bgcolor="#006461;"> 
			      <th width="60">번호</th>
			      <th width="100">종류</th>
			      <th>제목</th>
			      <th width="80">기안일</th>
			      <th width="60">파일첨부</th>
			  </tr>
			<c:forEach var="dto" items="${list}">
			  <tr align="center" style="border-bottom: 1px solid #cccccc;"> 
			      <td class="listNum">${dto.listNum}<input type="hidden" class="dtoSnum" value="${dto.snum}"></td>
			      <td class="stNum">${dto.stnum}</td>
			      <td align="left" style="padding-left: 10px;" class="ssubject">
			           <a class="articleSign">${dto.ssubject}</a>
			      </td>
			      <td>${dto.sdate}</td>
			      <td>파일 이미지</td>
			  </tr>
			</c:forEach>
			</table>
			 
			<table style=" margin: 9px 0px 0px 223px; width: 1000px;">
			   <tr>
				<td class="board-paging" align="center">
			         ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
				</td>
			   </tr>
			</table>
			
			<table style=" margin: 9px 0px 0px 223px; width: 1000px;">
			   <tr height="40">
			      <td align="left" width="100">
			          <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/sign/mainList';"><i class="fas fa-undo"></i></button>
			      </td>
			   </tr>
			</table>
        </div>
    </div>
</div>


