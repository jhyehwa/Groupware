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
		<div class="container-left" style="width: 23%; height: 860px; background: lime;">
			<div class="profile" style="margin-top: 2px;">
				<div class="profilePhoto" style="margin-top: 15px;">
					<table style="width: 180px; height: 180px; margin: 0px auto; margin-top: 5px;">
						<tr>
							<td style="text-align: center;">
								<img src="<%=cp%>/resource/images/woobin.jpg" style="width: 180px; height: 180px; border-radius: 90px;">
							<!-- 	<button style="width: 30px; height: 30px; vertical-align: middle; background: none; border: 1px solid #9565A4; color: #9565A4;">+</button> -->
							</td>
						</tr>			
					</table>	
				</div>
				
				<div class="profileInfo">
					<table style="width: 250px; height: 70px; margin: 0px auto; margin-top: 10px;">
						<tr style="text-align: center;">
							<td style="font-weight: bold;">  ${sessionScope.employee.name} </td>
						</tr>
						<tr style="text-align: center;">
							<td style="font-size: 16px;"> ${sessionScope.employee.dType} | ${sessionScope.employee.pType} </td>
						</tr>					
					</table>
				</div>
				
				<div class="inTime" style="margin-top: 10px; float: left; margin-left: 40px;">
					<table style="width: 100px; height: 100px; background:#9565A4;">
						<tr> 
							<td style="text-align: center;"> 출근 </td>
						</tr>
					</table>
				</div>
				
				<div class="outTime" style="margin-top: 10px; float: left; margin-left: 45px;">
					<table style="width: 100px; height: 100px; background:  #632A7E;">
						<tr> 
							<td style="text-align: center;"> 퇴근 </td>
						</tr>
					</table>
				</div>
				
				<div class="enterTime">
					<table style="width: 250px; height: 50px; margin: 0px auto;">
						<tr>
							<td style="text-align: center; padding-left: 5px;"> 09:00 </td>
							<td style="text-align: center; padding-left: 30px;"> 18:00 </td>
						</tr>
					</table>
				</div>
				
			</div>
			<div class="todo">
				<p> 투 두 </p>
			</div>
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