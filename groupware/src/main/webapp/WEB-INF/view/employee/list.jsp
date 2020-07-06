<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/employeeList.css" type="text/css">

<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}
</script>

<div class="container">
	<div id="list-container">
		<div class="body-title">
			<h3><i class="fa fa-quote-left"> 사원 정보</i></h3>
		</div>
	
		<div id="listBtnBox">
			<div id="listBtnBox-left">
				<button type="button" id="new-button1" class="listBtn" onclick="javascript:location.href='<%=cp%>/employee/employee';"><i class="fas fa-user-plus"></i></button>
				<button type="button" id="new-button2" class="listBtn" onclick="javascript:location.href='<%=cp%>/employee/list';"><i class="fas fa-undo-alt"></i></button>
			</div>
		
		
			<form name="searchForm" action="<%=cp%>/employee/list" method="post">
				<div class="selectGroup-list">
					<select name="condition" class="selectBox-list">
						<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
						<option value="enterDate" ${condition == "enterDate" ? "selected='selected'" : ""}>입사년도</option>								
						<option value="empNo" ${condition == "empNo" ? "selected='selected'" : "" }>사원번호</option>
						<option value="name" ${condition == "name" ? "selected='selected'" : ""}>이름</option>
						<option value="dType" ${condition == "dType" ? "selected='selected'" : ""}>부서</option>
						<option value="pType" ${condition == "pType" ? "selected='selected'" : ""}>직급</option>
					</select>
				</div>
				<div id="searchBox">
					<p><input type="text" name="keyword">
					<button type="button" onclick="searchList()"><i class="fas fa-search"></i></button>
					</p>
				</div>
			</form>
		
			<div id="container-list">
				<div id="list-header">
					<table id="list-menu">
						<tr id="list-title">
							<td id="empNo-list">사원번호</td>
							<td id="name-list">이름</td>
							<td id="tel-list">전화번호</td>
							<td id="email-list">이메일</td>
							<td id="enterDate-list">입사</td>
							<td id="dType-list">부서</td>
							<td id="pType-list">직위</td>
							<td id="search-list">상세</td>
						</tr>
						
						<c:forEach var="dto" items="${list}">
							<tr id="list-content">
								<td>${dto.empNo}</td>
								<td>${dto.name}</td>
								<td>${dto.tel}</td>
								<td>${dto.email}</td>
								<td>${dto.enterDate}</td>
								<td>${dto.dType}</td>
								<td>${dto.pType}</td>
								<td><a href="<%=cp%>/employee/article?employeeNum=${dto.employeeNum}&page=${page}"><i class="fas fa-search"></i></a></td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="8" id="list-paging">${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>