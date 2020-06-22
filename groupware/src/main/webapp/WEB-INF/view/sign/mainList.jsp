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

	$(function() {
		var url = "<%=cp%>/sign/signList";
		var query = "rows=" + 3;

		ajaxHTML(url, "GET", query, "#div1");
	});
	
	/*===============================================================*/
</script>
</head>
<body>

	<div class="container">
		<div class="board-container" style="margin: 30px 0 0 200px;">
			<div class="body-title">
				<h3>♬ 전자결재</h3>
			</div>
			<div style="float: right;">
				<button type="button" class="btnSend"
					onclick="javascript:location.href='<%=cp%>/sign/created';">새결재진행</button>
			</div>

			<div class="board-body" id="div1" style="border: 1px solid black; height: 200px;">
				<table style="margin-top: 20px;">
					<tr>
						<td align="left">&nbsp;</td>
						<td align="left"><h3>결재대기함</h3></td>
					</tr>
					
				</table>
				
				<table style="border-collapse: collapse;">
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
						<td>${dto.scurrStep==dto.sendStep ?'미결':'완료'}</td>
					</tr>
				</c:forEach>
				</table>
			</div>
			
			<div style="text-align: right;">
				<button type="button" class="btnPlus" id="btnPlus" name="btnPlus" onclick="javascript:location.href='<%=cp%>/sign/list?mode=1';">+</button>
			</div>
<div style="float: right;">
			</div>

			<div class="board-body" id="div1" style="border: 1px solid black; height: 200px;">
				<table style="margin-top: 20px;">
					<tr>
						<td align="left">&nbsp;</td>
						<td align="left"><h3>수신대기함</h3></td>
					</tr>
				</table>
				
				<table style="border-collapse: collapse;">
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
						<td>${dto.listNum}</td>
						<td align="left" style="padding-left: 80px;">
						<a href="#">${dto.ssubject}</a>
						</td>
						<td>파일이미지</td>
						<td>${dto.sdate}</td>
						<td>
							${dto.scurrStep=='0'?'미결':'완료'}
						</td>
					</tr>
				</c:forEach>
				</table>
			</div>
			
			<div style="text-align: right;">
				<button type="button" class="btnPlus" id="btnPlus" name="btnPlus" onclick="send();">들어가기</button>
			</div><div style="float: right;">
			</div>

			<div class="board-body" id="div1" style="border: 1px solid black; height: 200px;">
				<table style="margin-top: 20px;">
					<tr>
						<td align="left">&nbsp;</td>
						<td align="left"><h3>결재완료함</h3></td>
					</tr>
				</table>
				
				<table style="border-collapse: collapse;">
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
			
			<div style="text-align: right;">
				<button type="button" class="btnPlus" id="btnPlus" name="btnPlus" onclick="send();">들어가기</button>
			</div>

		</div>
	</div>
	
</body>
</html>