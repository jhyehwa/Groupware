<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<div id="list-Box">		
	<div id="speedInsertBox">
		<label><button type="button" id="excelOut" onclick="javascript:location.href='<%=cp%>/publicAddr/excel';"><i class="fas fa-file-export">&nbsp;내보내기</i></button></label>
	</div>
	
	<form name="addrAddForm" method="post">
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
					<td>생년월일</td>
					<td>전화번호</td>
					<td>이메일</td>
					<td>부서</td>
					<td>직위</td>
				</tr>
				
				<tr id="list-cotainer">
					<c:forEach var="dto" items="${list}">
						<tr id="list-content">
							<td>${dto.name}</td>
							<td>${dto.birth}</td>
							<td>${dto.tel}</td>
							<td>${dto.email}</td>
							<td>${dto.dType}</td>
							<td>${dto.pType}</td>
						</tr>
					</c:forEach>
				</tr>
				
				<tr>
					<td colspan="8" id="list-paging">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}</td>
				</tr>
			</table>
		</div>
	</form>
</div>