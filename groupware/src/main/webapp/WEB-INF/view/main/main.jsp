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
<script type="text/javascript">
$(function(){
	$("#todoBtn").click(function(){		
		$(".todoT").clone().appendTo("#todo");
	});
});

</script>

</head>
<body>

<div class="container">
	<div class="body-container">

	<div class="nav-left">
		<div class="container-left" style="width: 23%; height: 860px;">
			<div class="profile" style="margin-top: 2px;">
				<div class="profilePhoto" style="margin-top: 15px;">
					<table style="width: 180px; height: 180px; margin: 0px auto; margin-top: 5px;">
						<tr>
							<td style="text-align: center;">
								<c:if test="${sessionScope.employee.imageFilename != null}">
									<img src="<%=cp%>/uploads/profile/${sessionScope.employee.imageFilename}" style="width: 180px; height: 180px; border-radius: 90px;">
								</c:if>
								<c:if test="${sessionScope.employee.imageFilename == null}">
									<img src="<%=cp%>/resource/images/basic.gif" style="width: 180px; height: 180px; border-radius: 90px;">
								</c:if>
							<!-- 	<button style="width: 30px; height: 30px; vertical-align: middle; background: none; border: 1px solid #9565A4; color: #9565A4;">+</button> -->
							</td>
						</tr>			
					</table>	
				</div>
				
				<div class="profileInfo">
					<table style="width: 250px; height: 70px; margin: 0px auto; margin-top: 10px;">
						<tr style="text-align: center;">
							<td style="font-weight: bold;"> <a href="<%=cp%>/profile/list"> ${sessionScope.employee.name} </a> </td>
						</tr>
						<tr style="text-align: center;">
							<td style="font-size: 16px;"> ${sessionScope.employee.dType} | ${sessionScope.employee.pType} </td>
						</tr>					
					</table>
				</div>
				
				<div class="inTime" style="margin-top: 60px; float: left; margin-left: 40px;">
					<table style="width: 100px; height: 50px; border: 1px solid #9565A4; border-radius: 25px; color: #9565A4;">
						<tr> 
							<td style="text-align: center;"><button type="button" class="timeBtn" style="background: none; border: none; color:#9565A4;"> 출근 </button> </td>
						</tr>
					</table>
				</div>
				
				<div class="outTime" style="margin-top: 60px; float: left; margin-left: 45px;">
					<table style="width: 100px; height: 50px; border: 1px solid #9565A4; border-radius: 25px; color: #9565A4;">
						<tr> 
							<td style="text-align: center;"><button type="button" class="timeBtn" style="background: none; border: none; color:#9565A4;"> 퇴근 </button></td>
						</tr>
					</table>
				</div>
				
				<div class="enterTime">
					<table style="width: 250px; height: 50px; margin: 0px auto; padding-top: 10px;">
						<tr>
							<td style="text-align: left; padding-left: 10px; font-size: 17px; color: #6E6E6E;"> 출근 시간 </td>
							<td style="text-align: right; padding-right: 20px; font-size: 17px; color: #6E6E6E;"> 09:00:00 </td>
						</tr>
						<tr>
							<td style="text-align: left; padding-left: 10px; font-size: 17px; color: #6E6E6E;"> 퇴근 시간</td>
							<td style="text-align: right; padding-right: 20px; font-size: 17px; color: #6E6E6E;"> 18:00:00 </td>
						</tr>
					</table>
				</div>
				
			</div>
			
			<div class="todo" id="todo">
				<p style="margin-left: 15px; margin-top: 10px; font-weight: bold; margin-bottom: 15px;"> TO DO 
					<button type="button" id="todoBtn" class="todoBtn" style="border:none; background: none;">
						<i style="font-size: 22px;" class="far fa-plus-square"></i>
					</button>
				</p>
				
				<table class="todoT" style="width: 300px; height: 40px; font-size: 15px; padding: 3px 14px; margin-left: 15px;" >
					<tr>
						<td style="width: 75%; padding: 10px; border-bottom: 2px solid #9565A4;">
							<input type="text" name="content">
						</td>
						<td style="font-size: 18px; text-align: center; border: none;"><i class="fas fa-check-square"></i> <i class="fas fa-trash-alt"></i> </td>
					</tr>
				</table>
				
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