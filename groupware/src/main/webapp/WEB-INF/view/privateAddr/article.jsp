<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/privateAddr.css" type="text/css">

<div class="container">
	<div class="privateAddr-container">
		<div class="privateAddr-title">
			<h2>연락처 정보</h2>

			<form class="privateAddr-form" method="post">
				<input type="text" class="privateAddr-input" placeholder="이름" autofocus value="${dto.name}" readonly="readonly">
				<input type="text" class="privateAddr-input" placeholder="이메일" value="${dto.email}" readonly="readonly">
				<input type="text" class="privateAddr-input" placeholder="전화번호" value="${dto.tel}" readonly="readonly">
				<input type="text" class="privateAddr-input" placeholder="회사명" value="${dto.company}" readonly="readonly">
				<input type="text" class="privateAddr-input" placeholder="부서명" value="${dto.dName}" readonly="readonly">
				<input type="text" class="privateAddr-input" placeholder="회사번호" value="${dto.dTel}" readonly="readonly">
				<input type="text" class="privateAddr-input" placeholder="회사주소" value="${dto.dAddr}" readonly="readonly">
				<input type="text" class="privateAddr-input" placeholder="메모" value="${dto.memo}" readonly="readonly">
				<input type="text" class="privateAddr-input" placeholder="그룹분류" value="${dto.groupType}" readonly="readonly">
				
				<div class="button-container">
					<button type="button" class="privateAddr-button" onclick="javascript:location.href='<%=cp%>/privateAddr/update?addrNum=${addrNum}&page=${page}';">수정</button>
					<button type="button" class="privateAddr-button" onclick="javascript:location.href='<%=cp%>/privateAddr/list?${query}';">리스트</button>
				</div>
			</form>
		</div>
	</div>
</div>