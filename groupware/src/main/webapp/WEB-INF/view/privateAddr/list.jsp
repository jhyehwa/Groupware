<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<div id="list-Box">		
	<div id="speedInsertBox">
		<label><button id="addrAdd"><i class="fas fa-plus">&nbsp;빠른 등록</i></button></label>&nbsp;&nbsp;<!-- 호버 -->
		<label><button type="button" id="excelOut" onclick="javascript:location.href='<%=cp%>/privateAddr/excel';"><i class="fas fa-file-export">&nbsp;내보내기</i></button></label>
	</div>
	
	<form name="addrAddForm" method="post">
		<div id="speedInsert">
			<label id="textBox">
				<input type="text" name="name" id="name" placeholder="이름(표시명)"/>
				<input type="text" name="email" id="email" placeholder="이메일">
				<input type="text" name="tel" id="tel" placeholder="전화번호">
				<input type="hidden" name="groupNum" id="groupNum" value="${dto.groupNum}" placeholder="그룹분류" ${mode == "update" ? "disabled='disabled'" : ""}>
				<input type="text" name="groupType" id="groupType" value="${dto.groupType}" placeholder="그룹분류" readonly="readonly" ${mode == "update" ? "disabled='disabled'" : ""}>
				<a class="btn" href="#ex7"><button type="button" id="groupButton">그룹추가</button></a>
				<button type="button" id="groupAddButton" onclick="addrAdd();"><i class="fas fa-plus"> 추가</i></button>
			</label>
		</div>

		<div>
			<div id="addrPrivate">
				<ul>
					<li>
						<span class="all">전체</span>
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
				</ul>
			</div>
		</div>
		
		<div id="list-header">
			<table id="list-menu">
				<tr id="list-title">
					<td>이름</td>
					<td>전화번호</td>
					<td>이메일</td>
					<td>회사명</td>
					<td>그룹</td>
					<td>상세</td>
					<td>삭제</td>
				</tr>
				
				<tr id="list-cotainer">
					<c:forEach var="dto" items="${list}">
						<tr id="list-content">
							<td>${dto.name}</td>
							<td>${dto.tel}</td>
							<td>${dto.email}</td>
							<td>${dto.company}</td>
							<td>${dto.groupType}</td>
							<td><a href="<%=cp%>/privateAddr/update?addrNum=${dto.addrNum}&page=${page}"><i class="fas fa-search"></i></a></td>
							<td><button type="button" onclick="deletePrivateAddr('${dto.addrNum}');"><i class="fas fa-trash-alt"></i></button></td>
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
		<h3><i class="fas fa-object-group"></i> 그룹 추가 </h3>		

		<div class="board-created">
			<form name="modalGroup" method="post">
			
				<div class="jyy">
					<c:forEach var = "dto" items="${modalList}">
						<button type="button" class="groupNameList" name="groupNameList" data-groupType="${dto.groupType}" data-groupNum="${dto.groupNum}">${dto.groupType}</button>
					</c:forEach>
				</div>
			
				<div class="edit" id="edit">
					<input class="txt_mini" id="newGroupName" name="groupType" type="text" placeholder="새 그룹 이름">
					<button type="button" id="saveGroup" name="saveGroup"><i class="far fa-check-square"></i></button>
					<button type="reset" id="edit-reset"><i class="fas fa-undo-alt"></i></button>
				</div>
			
		  		<div id="newGroupAdd">
		    		<button type="button" id="groupAdd">새 그룹 추가</button>
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