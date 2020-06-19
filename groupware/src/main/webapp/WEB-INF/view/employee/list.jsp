<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}
</script>

<div class="container">
	<div class="board-container">
		<div class="body-title">
			<h3><i class="fa fa-quote-left"> 사원 정보</i></h3>
		</div>
	</div>
	
	<div class="board-body">
		<table>
		   <tr>
		      <td>
		          &nbsp;
		      </td>
		   </tr>
		</table>
			
		<table class="list-menu">
			<tr class="list-title">
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
				<tr align="center" style="border-bottom: 1px solid #cccccc;">
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
		</table>
		
		<table style="margin: 10px 0 0 100px;">
		   <tr>
			<td class="board-paging" align="center">
		         ${dataCount==0 ? "등록된 게시물이 없습니다.":paging}
			</td>
		   </tr>
		</table>
			
		<table style="margin-top: 10px">
			<tr height="40">
				<td align="left" width="100">
					<button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/employee/list';">새로고침</button>
				</td>
				
				<td align="center">
					<form name="searchForm" action="<%=cp%>/employee/list" method="post">
						<select name="condition" class="selectField">
							<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
							<option value="enterDate" ${condition == "enterDate" ? "selected='selected'" : ""}>입사년도</option>								
							<option value="empNo" ${condition == "empNo" ? "selected='selected'" : "" }>사원번호</option>
							<option value="name" ${condition == "name" ? "selected='selected'" : ""}>이름</option>
							<option value="dType" ${condition == "dType" ? "selected='selected'" : ""}>부서</option>
							<option value="pType" ${condition == "pType" ? "selected='selected'" : ""}>직급</option>
						</select>
						<input type="text" name="keyword" class="boxTF">
						<button type="button" class="boardBtn" onclick="searchList()">검색</button>
					</form>
				</td>
				<td align="right" width="100">
					<button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/employee/employee';">사원등록</button>
				</td>
			</tr>
		</table>
	</div>
</div>