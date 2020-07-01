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

<link rel="stylesheet" href="<%=cp%>/resource/fullcalendar/fullcalendar.min.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/fullcalendar/fullcalendar.print.min.css" media='print' type="text/css">
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/lib/moment.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/fullcalendar.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/locale-all.js"></script>

<link rel="stylesheet" href="<%=cp%>/resource/css/home.css" type="text/css">
<script type="text/javascript">
function deleteTodo(num) {
	var q = "todoNum="+num;
	var url = "<%=cp%>/main/delete?" + q;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")){
		  	location.href=url;
	}
}

 $(function(){
	$("#todoBtn").click(function(){	
		
		var out = "";
		
		out += "<tr>";
		out += "	<td style='width: 75%; padding: 10px; border-bottom: 2px solid #9565A4;'>";
		out += "		<input type='text' name='content' style='border: none;' required='required'>";
		out += "	</td>";
		out += "	<td style='font-size: 18px; text-align: center; border: none;'>";
		out += "		<button type='submit' style='background: none; border: none; color: #2E2E2E;'><i class='fas fa-check'></i></button>";
		out += "		<button type='button' onclick='deleteTodo(${dto.todoNum});' style='background: none; border: none;'>";
		out += "			<i class='fas fa-trash-alt' style='color: #2E2E2E;''></i></button>";
		out += "	</td>";
		out += "</tr>";
	
	   var $table = $(".todoT");
	   
	   var length = $(".todoT tr").length;
	   
       $(".todoT").append(out);
       
       if(length > 4) {
    	   return;
       }

	});
}); 
</script>

<script>
function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data, text, request) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

$(function(){
	$(".cssChange").click(function(){
		$(this).parent("div").find("input[type=text]").css("text-decoration", "line-through");
	});
});

function showInTime(){
    var currentDate = new Date();
    var divClock = document.getElementById("divClockIn");
     
    var msg = currentDate.getHours()+":"
    msg += currentDate.getMinutes()+":";
    msg += currentDate.getSeconds();
     
    divClockIn.innerText = msg;
}

function showOutTime(){
    var currentDate = new Date();
    var divClock = document.getElementById("divClockOut");
     
    var msg = currentDate.getHours()+":"
    msg += currentDate.getMinutes()+":";
    msg += currentDate.getSeconds();
     
    divClockOut.innerText = msg;
}

// 오늘날짜 출력

$(function(){
	var today = new Date();
	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate();  // 날짜
	var day = today.getDay();  // 요일
		if(day==0) {day="일요일";}
		else if(day==1) {day="월요일";}
		else if(day==2) {day="화요일";}
		else if(day==3) {day="수요일";}
		else if(day==4) {day="목요일";}
		else if(day==5) {day="금요일";}
		else {day="토요일";}
	
		var out = "";
		out += year + "년 " + month + "월 " + date + "일 " + day;

		$("#clockkk").append(out);	

});		

 
//달력
var calendar=null;
var group="all";
var tempContent;

//start:2016-01-01 => 2016-01-01 일정
//start:2016-01-01, end:2016-01-02 => 2016-01-01 일정
//start:2016-01-01, end:2016-01-03 => 2016-01-01 ~ 2016-01-02 일정
$(function() {		
		//스케쥴러
		calendar = $("#weekcalendar").fullCalendar({
			height:200,
			header: {
			left   : 'none'
			},
			defaultView: 'basicWeek'
			,
		});

});
</script>



</head>
<body>

<div class="container">
	<div class="body-container">

	<div class="nav-left">
		<div class="container-left" style="width: 23%; height: 860px;">
			<div class="profile" style="margin-top: 15px;">
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
							<td style="text-align: center;"><button type="button" class="timeBtn" onclick="showInTime()" style="background: none; border: none; color:#9565A4;"> 출근 </button> </td>
						</tr>
					</table>
				</div>
				
				<div class="outTime" style="margin-top: 60px; float: left; margin-left: 45px;">
					<table style="width: 100px; height: 50px; border: 1px solid #9565A4; border-radius: 25px; color: #9565A4;">
						<tr> 
							<td style="text-align: center;"><button type="button" class="timeBtn" onclick="showOutTime()" style="background: none; border: none; color:#9565A4;"> 퇴근 </button></td>
						</tr>
					</table>
				</div>
				
				<div class="enterTime">
					<table style="width: 250px; height: 50px; margin: 0px auto; padding-top: 10px;">
						<tr>
							<td style="text-align: left; padding-bottom: 7px; padding-left: 10px; font-size: 17px; color: #6E6E6E;"> 출근 시간 </td>
							<td style="text-align: right; padding-right: 20px; font-size: 17px; color: #6E6E6E;"> <div id="divClockIn" class="clock"></div> </td>
							
						</tr>
						<tr>
							<td style="text-align: left; padding-left: 10px; font-size: 17px; color: #6E6E6E;"> 퇴근 시간</td>
							<td style="text-align: right; padding-right: 20px; font-size: 17px; color: #6E6E6E;"> <div id="divClockOut" class="clock"></div> </td>
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
				
			
				<form name="todoForm" action="<%=cp%>/main/created" method="POST">
				<table class="todoT" style="width: 300px; height: 40px; font-size: 15px; padding: 3px 14px; margin-left: 15px;" >
					<c:forEach var="dto" items="${list}">
					<tr>
						<td style="width: 78%; padding: 10px; padding-left: 5px; padding-right: 0px; border-bottom: 2px solid #9565A4;">
							<div class="todoContent">
								<button type="button" style="background: none; border: none;" class="cssChange"><i class="fas fa-clipboard-check" style="font-size: 18px;"></i>	</button> &nbsp;
								<input type="text" name="content" value="${dto.content}" style="border: none;" required="required" disabled="disabled">
							</div>	
						</td>
						<td style="font-size: 18px; text-align: center; border: none;">
							<button type="submit" style="background: none; border: none; color: #632A7E;">
								<i class="fas fa-check-square"></i></button>
							<button type="button" onclick="deleteTodo(${dto.todoNum});" style="background: none; border: none;">
								<i class="fas fa-trash-alt" style="color: #2E2E2E;"></i></button>
						</td>
					</tr>
					</c:forEach>
					<c:if test="${list.size()==0}">
					 <tr>
						<td style="width: 75%; padding: 10px; border-bottom: 2px solid #9565A4;">
							<input type="text" name="content" style="border: none;" required="required"> 
						</td>
						<td style="font-size: 18px; text-align: center; border: none;">
							<button type="submit" style="background: none; border: none; color: #2E2E2E;">
								<i class="fas fa-check"></i></button>
							<button type="button" onclick="deleteTodo(${dto.todoNum});" style="background: none; border: none;">
								<i class="fas fa-trash-alt" style="color: #2E2E2E;"></i></button>
						</td>
					</tr>
					</c:if>
				</table>
				</form>
		
				
			</div>
		</div>
	</div>
	
		
	<div class="nav-right">
		<div class="container-top">
			<div class="content-date">
				<ul>
					<li id="clockkk"></li>
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
				<div  id="weekcalendar"></div>
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