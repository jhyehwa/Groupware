<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/employee.css" type="text/css">

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
	</div>
	
	<table id="search">
			<tr>
				<td id="search-form">
					<form name="searchForm" action="<%=cp%>/employee/list" method="post">
						<div class="selectGroup-list1">
							<select name="condition" class="selectBox-list1">
								<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
								<option value="enterDate" ${condition == "enterDate" ? "selected='selected'" : ""}>입사년도</option>								
								<option value="empNo" ${condition == "empNo" ? "selected='selected'" : "" }>사원번호</option>
								<option value="name" ${condition == "name" ? "selected='selected'" : ""}>이름</option>
								<option value="dType" ${condition == "dType" ? "selected='selected'" : ""}>부서</option>
								<option value="pType" ${condition == "pType" ? "selected='selected'" : ""}>직급</option>
							</select>
						<input type="text" name="keyword">
						<button type="button" onclick="searchList()" id="clickBtn">검색</button>
						</div>
					</form>
				</td>					
			</tr>
		</table>
	
	<div id="list-header">
		<table id="list-menu">
			<tr id="list-title">
				<td>사원번호</td>
				<td>이름</td>
				<td>전화번호</td>
				<td>이메일</td>
				<td>입사</td>
				<td>부서</td>
				<td>직위</td>
				<td>상세</td>
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
			
			<tr id="listBtnBox">
				<td colspan="8" id="listBtnBox-left">
					<button type="button" id="new-button1" onclick="javascript:location.href='<%=cp%>/employee/list';"><i class="fas fa-undo-alt"></i></button>
					<button type="button" id="new-button2" onclick="javascript:location.href='<%=cp%>/employee/employee';">사원등록</button>
				</td>
			</tr>
		</table>
	</div>
</div>