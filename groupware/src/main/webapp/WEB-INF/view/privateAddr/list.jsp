<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link rel="stylesheet" href="<%=cp%>/resource/css/privateAddr.css" type="text/css">

<script>
	$(function(){
		$(".kor").click(function(){
			//alert($(this).attr("data-kor"));
			
			var kor = $(this).attr("data-kor");
			var kor2 = $(this).closest("li").next().find("span").attr("data-kor");
			
			var url = "<%=cp%>/privateAddr/list";
			var query = "kor=" + kor + "&kor2=" + kor2 ;
			var selector = "#tab-content";
			
			ajaxHTML(url, "get", query, selector);
		});
	});
</script>

<script>
	//+버튼 누르면 hidden, show
	$(document).ready(function(){
		$("#addrAdd").click(function(){
			$("#textBox").slideToggle();
		});
	});
</script>

<div style="width: 1000px; margin: -100px 0 0 300px; float: left;">		
	<div style="background: yellow; height: 50px; line-height: 55px; font-size: 15px;">
		<label id="addrAdd">&nbsp;<i class="fas fa-plus">&nbsp;빠른 등록</i></label>&nbsp;&nbsp;<!-- 호버 -->				
		<label id="btnDeleteList"><i class="fas fa-trash-alt">&nbsp;삭제</i></label>&nbsp;&nbsp;
		<label><a href="#"><i class="fas fa-copy">&nbsp;주소록 복사</i></a></label>&nbsp;&nbsp;
		<label><a href="javascript:location.href='<%=cp%>/privateAddr/excel';"><i class="fas fa-file-export">&nbsp;내보내기</i></a></label>
	</div>
	
	<form name="addrAddForm" method="post">
		<div style="background: aqua; height: 40px; padding-top: 5px; padding-left: 5px;">
			<label id="textBox">
				<input type="text" name="name" id="name" placeholder="이름(표시명)" style="height: 30px;">
				<input type="text" name="email" id="email" placeholder="이메일" style="height: 30px;">
				<input type="text" name="tel" id="tel" placeholder="전화번호" style="height: 30px;">					
				<input type="hidden" name="groupNum" id="groupNum" value="${dto.groupType}" placeholder="그룹분류" ${mode == "update" ? "disabled='disabled'" : ""}  style="height: 30px;">
				<a class="btn" href="#ex7"><button type="button">그룹추가</button></a>
				<button type="button" style="height: 35px; width: 30px;" onclick="addrAdd();"><i class="fas fa-user-plus" style="background: red; font-size: 18px;"></i></button>
				<a href="#">상세정보추가</a>
			</label>
		</div>
		
		<div>
			<div class="aa">
				<ul>
					<li>
						<span data-kor="all">전체</span>
					</li>
					<li>
						<span data-kor="가" class="kor">ㄱ</span>
					</li>
					<li>
						<span data-kor="나" class="kor">ㄴ</span>
					</li>
					<li>
						<span data-kor="다" class="kor">ㄷ</span>
					</li>
					<li>
						<span data-kor="라" class="kor">ㄹ</span>
					</li>
					<li>
						<span data-kor="마" class="kor">ㅁ</span>
					</li>
					<li>
						<span data-kor="바" class="kor">ㅂ</span>
					</li>
					<li>
						<span data-kor="사" class="kor">ㅅ</span>
					</li>
					<li>
						<span data-kor="아" class="kor">ㅇ</span>
					</li>
					<li>
						<span data-kor="자" class="kor">ㅈ</span>
					</li>
					<li>
						<span data-kor="차" class="kor">ㅊ</span>
					</li>
					<li>
						<span data-kor="카" class="kor">ㅋ</span>
					</li>
					<li>
						<span data-kor="타" class="kor">ㅌ</span>
					</li>
					<li>
						<span data-kor="파" class="kor">ㅍ</span>
					</li>
					<li>
						<span data-kor="하" class="kor">ㅎ</span>
					</li>
					<li>
						<span data-kor="etc" class="kor">etc</span>
					</li>
				</ul>
			</div>
		</div>
		
		<div id="list-header">
			<table id="list-menu">
				<tr id="list-title">
					<td><input type="checkbox" name="checkAll" id="checkAll" value="all"></td>
					<td>이름</td>
					<td>전화번호</td>
					<td>이메일</td>
					<td>회사명</td>
					<td>그룹</td>
					<td>상세</td>
				</tr>
				
				<tr id="list-cotainer">
					<c:forEach var="dto" items="${list}">
						<tr id="list-content">
							<td><input type="checkbox" name="addrNum" value="${dto.addrNum}"></td>
							<td>${dto.name}</td>
							<td>${dto.tel}</td>
							<td>${dto.email}</td>
							<td>${dto.company}</td>
							<td>${dto.groupType}</td>
							<td><a href="<%=cp%>/privateAddr/update?addrNum=${dto.addrNum}&page=${page}"><i class="fas fa-search"></i>${dto.addrNum}</a></td>
						</tr>
					</c:forEach>
				</tr>
				
				<tr>
					<td colspan="8" id="list-paging">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}</td>
				</tr>
			</table>
		</div>
	</form>
	
	<!-- 모달창 -->
	<div id="ex7" class="modal">
		<p> &nbsp; </p>	
		<h3><i class="far fa-object-group" style="font-size: 25px;"></i> 그룹 추가 </h3>		

		<div class="board-created">
			<form name="modalGroup" method="post">
			
				<div class="jyy">
					<c:forEach var = "dto" items="${modalList}">
						<button type="button" class="groupNameList" name="groupNameList" data-groupType="${dto.groupType}" data-groupNum="${dto.groupNum}">${dto.groupType}</button>
					</c:forEach>
				</div>
			
				<div class="edit" id="edit" style="display: none;">
					<input class="txt_mini edit" id="newGroupName" name="groupType" type="text" placeholder="새 그룹 이름">
					<button type="button" id="saveGroup"><i class="far fa-check-square"></i></button>
					<button type="reset"><i class="fas fa-undo-alt"></i></button>
				</div>
			
		  		<div style="width: 450px; margin-top: 10px;">
		    		<button type="button" id="groupAdd">+ 새그룹</button>
		     	</div>
			</form>
		</div>
	</div>
	
	<script>
		$('a[href="#ex7"]').click(function(event) {
			event.preventDefault();

			$(this).modal({
				fadeDuration : 250,
			});
		});
	</script>
</div>