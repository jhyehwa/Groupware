<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
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
	function ajaxHTML(url, type, query, selector) {
		$.ajax({
			type : type,
			url : url,
			data : query,
			success : function(data) {
				$(selector).html(data);
			},
			error : function(e) {
				console.log(e.responseText);
			}
		});
	}
<%-- 
	$(function() {
		var url = "<%=cp%>/sign/signList";
		var query

		ajaxHTML(url, "GET", query, "#div1");
	}); --%>
	
	/*===============================================================*/
	
	function searchList(){
		var f = document.searchForm;
		
		var str = f.keyword.value;
		if(! str){
			alert("빈내용은 검색 할 수 없습니다.");
			f.condition.focus();
			return;
		}
		
		f.submit();
	}
	
</script>
</head>
<body>
	<div class="body-title" style="margin : 40px 0px 0px 300px;">
				<span style="font-size: 20px; font-family: '맑은고딕'; font-weight: 900;">♬ 전자결재</span>
	</div>
		<div style="float: left; margin-left:130px; margin-top: 40px;">
				<button type="button" class="btnSend" style="width: 200px; height: 50px; border-radius: 10px; border: none; background: #9565A4;" onclick="javascript:location.href='<%=cp%>/sign/created';">
					<i class="fas fa-paste" style="color: white; font-size: 18px;">&nbsp;새결재진행 &nbsp;</i><i class="fas fa-plus"  style="color: white; font-size: 18px;"></i>
				</button><br>
				
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

		<div class="board-container" style="margin: auto; width: 1050px;">
			<div class="board-body" id="div1" style="border-bottom: 3px solid #9565A4; height: 300px; ">
				<table style="margin: 20px auto;">
					<tr>
						<td align="left"><h3>결재대기함</h3></td>
					</tr>
					
				</table>
				
				<div style="height: 140px;">
				<table style="border-collapse: collapse; margin: auto; width: 1000px;">
					<tr align="center" bgcolor="#006461;">
						<th width="80">기안자</th>
						<th>제목</th>
						<th width="100">첨부</th>
						<th width="80">기안일</th>
						<th width="60">결재상태</th>
					</tr>
					
				<c:if test="${list.size()==0}">
					 <tr>
						<td class="board-paging" align="center" colspan="5">
			     		   <p>등록된 게시물이 없습니다.</p>
						</td>
				    </tr>
				</c:if>
				<c:forEach var="dto" items="${list}">
					<tr align="center" style="border-bottom: 1px solid #cccccc;">
						<td>${dto.name}</td>
						<td align="left" style="padding-left: 80px;">
						<a href="#">${dto.ssubject}</a>
						</td>
						<td>파일이미지</td>
						<td>${dto.sdate}</td>
						<td>${dto.scurrStep!=dto.sendStep ?'미결':'완료'}</td>
					</tr>
				</c:forEach>
				</table>
				</div>
				<div style="text-align: right; margin: auto;" class="buttonDiv">
					<button type="button" class="btnPlus" id="btnPlus" name="btnPlus" onclick="javascript:location.href='<%=cp%>/sign/list?mode=1';">+</button>
				</div>
				
			</div>
			

			<div class="board-body" id="div1" style="border-bottom: 3px solid #9565A4; height: 300px;">
				<table style="margin-top: 20px;">
					<tr>
						<td align="left">&nbsp;</td>
						<td align="left"><h3>수신대기함</h3></td>
					</tr>
				</table>
				
				<div style="height: 140px;">
				<table style="border-collapse: collapse;  margin: auto">
					<tr align="center" bgcolor="#006461;">
						<th width="80">기안자</th>
						<th>제목</th>
						<th width="100">첨부</th>
						<th width="80">기안일</th>
						<th width="60">결재상태</th>
					</tr>
					<c:if test="${rlist.size()==0}">
						 <tr>
							<td class="board-paging" align="center" colspan="5">
			     			   <p>등록된 게시물이 없습니다.</p>
							</td>
				  	  </tr>
					</c:if>
	
				<c:forEach var="dto" items="${rlist}">
					<tr align="center" style="border-bottom: 1px solid #cccccc;">
						<td>${dto.name}</td>
						<td align="left" style="padding-left: 80px;">
						<a href="#">${dto.ssubject}</a>
						</td>
						<td>파일이미지</td>
						<td>${dto.sdate}</td>
						<td>
							${dto.scurrStep!=dto.sendStep ?'미결':'완료'}
						</td>
					</tr>
				</c:forEach>
				</table>
				</div>
			<div style="text-align: right; margin: auto;" class="buttonDiv">
					<button type="button" class="btnPlus" id="btnPlus" name="btnPlus" onclick="javascript:location.href='<%=cp%>/sign/list?mode=2';">+</button>
				</div>
			</div>
			
			<div class="board-body" id="div1" style="border-bottom: 3px solid #9565A4; height: 300px;">
				<table style="margin-top: 20px;">
					<tr>
						<td align="left">&nbsp;</td>
						<td align="left"><h3>결재완료함</h3></td>
					</tr>
				</table>
				
				
				<div style="height: 140px;">
				<table style="border-collapse: collapse;  margin: auto">
				<tr align="center" bgcolor="#006461;">
						<th width="80">기안자</th>
						<th>제목</th>
						<th width="100">첨부</th>
						<th width="80">기안일</th>
						<th width="60">결재상태</th>
					</tr>
				<c:if test="${flist.size()==0}">
						 <tr>
							<td class="board-paging" align="center" colspan="5">
			     			   <p>등록된 게시물이 없습니다.</p>
							</td>
				  	  </tr>
					</c:if>
				
				<c:forEach var="dto" items="${flist}">
					<tr align="center" style="border-bottom: 1px solid #cccccc;">
						<td>${dto.listNum}</td>
						<td align="left" style="padding-left: 80px;">
						<a href="#">${dto.ssubject}</a>
						</td>
						<td>파일이미지</td>
						<td>${dto.sdate}</td>
						<td>${dto.scurrStep=='0'?'미결':'완료'}</td>
					</tr>
				</c:forEach>
				</table>
				</div>
			
			<div style="text-align: right; margin: auto;" class="buttonDiv">
					<button type="button" class="btnPlus" id="btnPlus" name="btnPlus" onclick="javascript:location.href='<%=cp%>/sign/list?mode=3';">+</button>
				</div>
			</div>
		</div>
	
</body>
</html>