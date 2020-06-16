<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=cp%>/resource/css/home.css" type="text/css">

</head>
<body>

<div class="container">
	<div class="body-container">

	<div class="nav-left">
		<div class="container-left">
			<ul class="profile">
				<li>프로피리이랑리아</li>
			</ul>
			<ul class="todo">
				<li>투두우ㅜㅜㅜㅇㅇㅇㅇㅇ우ㅜㅜㅜㅜ</li>
			</ul>
		</div>
	</div>
	
		
	<div class="nav-right">
		<div class="container-top">
			<div class="content-date">
				<ul>
					<li>2020년 6월 11일 목요일 </li>
				</ul>
			</div>
			<div class="content-weather">	
				<ul>
					<li>날씨:흐림</li>
				</ul>
			</div>
		</div>
		
		<div class="content-top">
			<div class="content-schedule" >
				<ul>
					<li >일정임 </li>
				</ul>
			</div>
		
			<div class="content-bottom">
				<div class="content-todayTalk" >
					<ul >
						<li >오늘의한마디 </li>
					</ul>
				</div>
				<div class="content-right">
					<div class="content-buddy" >
						<ul >
							<li>쪼옥지 </li>
						</ul>
					</div>
					<div class="content-notice" >
						<ul>
							<li >고옹지 </li>
						</ul>
					</div>
				</div>
			</div>
			
		</div>
		
	</div>
</div>
</div>
</body>
</html>