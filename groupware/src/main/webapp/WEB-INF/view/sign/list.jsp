<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

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
				width : 1200,
				height : 1150,
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
	
	
</script>

<!-- 아티클 모달 -->
<div id="articleModal-dialog" class="articleModal">
	<div class="showSing"  style="width: 1000px; height:950px; display: none; border: 1px solid black">
		
	</div>
</div>

<div class="container">
    <div class="board-container">
        <div class="body-title">
            <h3>
            ${mode}
            </h3>
        </div>
        
        <div class="board-body">
			<table style="margin-top: 20px;">
			   <tr>
			      <td align="left">
			          &nbsp;
			      </td>
			      <td align="right">
			          ${dataCount}개(${page}/${total_page} 페이지)
			      </td>
			   </tr>
			</table>
			
			<table style="border-collapse: collapse;">
			  <tr align="center" bgcolor="#006461;"> 
			      <th width="60">번호</th>
			      <th width="100">종류</th>
			      <th>제목</th>
			      <th width="80">기안일</th>
			      <th width="60">파일첨부</th>
			  </tr>
			<c:forEach var="dto" items="${list}">
			  <tr align="center" style="border-bottom: 1px solid #cccccc;"> 
			      <td class="listNum">${dto.listNum} / ${dto.snum}<input type="hidden" class="dtoSnum" value="${dto.snum}"></td>
			      <td class="stNum">${dto.stnum}</td>
			      <td align="left" style="padding-left: 10px;" class="ssubject">
			           <a class="articleSign">${dto.ssubject}</a>
			      </td>
			      <td>${dto.sdate}</td>
			      <td>파일 이미지</td>
			  </tr>
			</c:forEach>
			</table>
			 
			<table>
			   <tr>
				<td class="board-paging" align="center">
			         ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
				</td>
			   </tr>
			</table>
			
			<table style="margin-top: 10px ">
			   <tr height="40">
			      <td align="left" width="100">
			          <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/sign/list?mode=${mode}';">새로고침</button>
			      </td>
			      <td align="center">
			          <form name="searchForm" action="<%=cp%>/sign/list" method="post">
			              <select name="condition" class="selectField">
			                  <option value="all" ${condition=="all"?"selected='selected'":""}>::검색::</option>
			                  <option value="title" ${condition=="title"?"selected='selected'":""}>제목</option>
			                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
			                  <option value="option" ${condition=="content"?"selected='selected'":""}>종류</option>
			                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
			            </select>
			            <input type="hidden" name="mode" value="${mode}" >
			            <input type="text" name="keyword" class="boxTF">
			            <button type="button" class="boardBtn" onclick="searchList()">검색</button>
			        </form>
			      </td>
			      <td align="right" width="100">
			          <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/sign/created';">글올리기</button>
			      </td>
			   </tr>
			</table>
        </div>
    </div>
</div>


