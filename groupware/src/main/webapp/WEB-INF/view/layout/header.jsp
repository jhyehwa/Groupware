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
			<a href="<%=cp%>/">
			<span>로 혜화네</span>
			<br>
			<span>고 회사</span>
			</a>
		</p>
	</div>
	<div class="header-right">
		<div class="header-menu">
			<a href="#"><i class="far fa-user-circle"></i></a> <!-- 프로필 -->
			<span>${sessionScope.employee.name}</span>님
			&nbsp;&nbsp;
			<a href="#"><i class="far fa-bell"></i></a> <!-- 알림 -->
			&nbsp;&nbsp;
			<a href="#"><i class="fas fa-bars"></i></a> <!-- 메뉴 -->
		</div>
	</div>
</div>