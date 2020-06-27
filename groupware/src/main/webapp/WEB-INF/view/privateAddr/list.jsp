<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link rel="stylesheet" href="<%=cp%>/resource/css/privateAddr.css" type="text/css">

<script type="text/javascript">
	//+버튼 누르면 hidden, show
	$(document).ready(function(){
		$("#addrAdd").click(function(){
			$("#textBox").slideToggle();
		});
	});
</script>

<script>
function addrAdd() {
	var f = document.addrAddForm;
	var str;
	
	str = f.name.value;
	str = str.trim();
	
	if(!str) {
		alert("이름을 입력해주세요.");
		f.name.focus();
		return;
	}
	
	str = f.email.value;
	str = str.trim();
	
	if(!str) {
		alert("이메일을 입력해주세요.");
		f.email.focus();
		return;
	}
	
	str = f.tel.value;
	str = str.trim();
	
	if(!str) {
		alert("전화번호를 입력해주세요.");
		f.tel.focus();
		return;
	}
	
 	f.action = "<%=cp%>/privateAddr/privateAddr2";
 	
   	f.submit();
}
</script>

<script>

// 모달창 그룹 추가 버튼 누르면 효과
$(document).ready(function(){
	$("#groupAdd").click(function(){
		$("#edit").slideDown("slow");
	});
});



// 모달창 리스트 & 추가
$(function(){
	$("#saveGroup").click(function(){
		
		var query=$("form[name=modalGroup]").serialize();
		var url="<%=cp%>/privateAddr/modalInsert";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType : "JSON"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					location.href="<%=cp%>/privateAddr/privateAddr";
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		location.href="<%=cp%>/login";
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	});
});



// 모달창에 그룹 추가
function saveGroup() {
	var f = document.privateAddrForm;
	var str = $("#groupName").val();
	
	f.action = "<%=cp%>/privateAddr/modalList";
 	
   	f.submit();
}



 $(function(){
	$(".groupNameList").click(function(){
		
		var groupType;
 		$("body").on("click", ".groupNameList", function(){
 			groupNum=$(this).attr("data-groupNum");
		 	$("#groupNum").val(groupNum);
		});
	}); 
});
</script>

<style>
.aa ul li {
	float: left;
	height: 50px;
	margin-top: 10px;
	padding-top: 30px;
	margin-right: 20px; 
}

.aa ul li a {
	color: white;
}
</style>

<div class="container">
	<div id="list-container">
	<div id="body-title">
		<i class="fa fa-quote-left"> 개인주소록</i><span>&nbsp;&nbsp;${dataCount}개(${page}/${total_page} 페이지)</span>
	</div>
	
	<div id="listBtnBox">
		<div id="listBtnBox-left">
			<button type="button" style="width: 150px; height: 50px; margin-top: 30px; margin-left: 40px; background: #9565A4; color: white; font-size: 25px; border: none; border-radius: 10px;" onclick="javascript:location.href='<%=cp%>/privateAddr/privateAddr';">
			 	<i class="fas fa-user-plus"></i>
			</button>
		</div>
	
	
	
	<form name="searchForm" action="<%=cp%>/privateAddr/list" method="post">
		<div class="selectGroup-list">
			<select name="condition" class="selectBox-list">
				<option value="all" ${condition=="all"?"selected='selected'":""}>주소록</option>
			</select>
		</div>
		<div style="margin-left: 20px; margin-top: -10px;">
			<p style="font-size: 20px; border: 1px solid #cccccc; width: 220px;"><input type="text" name="keyword" style="width: 170px; height: 35px; border: none; font-size: 15px; padding-left: 10px; outline: 0; autocomplete: off;">
			<button type="button" onclick="searchList()" style="border: none; background: transparent; outline: 0; width: 30px; height: 30px; margin-top: 5px;">검색</button>
		</div>
	</form>





	<div id="list-container">		
		
		
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
					<input type="text" name="groupNum" id="groupNum" value="${dto.groupType}" placeholder="그룹분류" ${mode == "update" ? "disabled='disabled'" : ""}  style="height: 30px;">
					<a class="btn" href="#ex7"><button type="button"><i class="far fa-plus-square" style="height: 30px; width: 30px; font-size: 20px;"></i></button></a>
					<button type="button" style="height: 30px; width: 30px;" onclick="addrAdd();"><i class="fas fa-user-plus"></i></button>
					<a href="#">상세정보추가</a>
				</label>
			</div>
			
			<div>
				<div class="aa">
					<ul>
						<li>
							<a href="" class="kor"><span data-kor="all">전체</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="가">ㄱ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="나">ㄴ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="다">ㄷ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="라">ㄹ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="마">ㅁ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="바">ㅂ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="사">ㅅ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="아">ㅇ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="자">ㅈ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="차">ㅊ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="카">ㅋ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="타">ㅌ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="파">ㅍ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="하">ㅎ</span></a>
						</li>
						<li>
							<a href="" class="kor"><span data-kor="etc">etc</span></a>
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
	</div>
	</div>
</div>