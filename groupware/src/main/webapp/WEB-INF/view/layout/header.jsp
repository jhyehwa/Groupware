<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<div class="header-top">
	<div class="header-left">
		<p style="margin: 2px;">
			<a href="<%=cp%>/login">
			<span>로 혜화네</span>
			<br>
			<span>고 회사</span>
			</a>
		</p>
	</div>
	<div class="header-right">
		<div class="header-menu">
			<c:if test="${not empty sessionScope.employee}">
				<span style="color: white; margin-right: 10px; font-size: 15px;">${sessionScope.employee.name}님</span>
				<c:if test="${not empty sessionScope.employee.imageFilename}">
					<a href="<%=cp%>/profile/list"><img src="<%=cp%>/uploads/profile/${sessionScope.employee.imageFilename}" style="width: 36px; height: 36px; margin-right: 5px; border-radius: 18px;"></a>
				</c:if>
				<c:if test="${empty sessionScope.employee.imageFilename}">
					<a href="<%=cp%>"><i class="far fa-user-circle" style="margin-right: 5px;"></i></a> <!-- 프로필 -->
				</c:if>
				&nbsp;
			</c:if>
			
			<a href="#"><i class="far fa-bell"></i></a> <!-- 알림 -->
			&nbsp;
			<a href="#"><i class="fas fa-bars"></i></a> <!-- 메뉴 -->
			&nbsp;
			<c:if test="${sessionScope.employee.rCode == 'admin'}">
				<a href="<%=cp%>/employee/list"><i class="fas fa-user-cog"></i></a> <!-- 관리자 -->
				&nbsp;
			</c:if>
			<c:if test="${not empty sessionScope.employee}">
				<a href="<%=cp%>/employee/logout"><i class="fas fa-sign-out-alt"></i></a>
			</c:if>
		</div>
	</div>
</div>