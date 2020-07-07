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

<link rel="stylesheet" href="<%=cp%>/resource/css/talk.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/fullcalendar/fullcalendar.min.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/weekcalendar.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/fullcalendar/fullcalendar.print.min.css" media='print' type="text/css">
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/lib/moment.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/fullcalendar.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/fullcalendar/locale-all.js"></script>

<link rel="stylesheet" href="<%=cp%>/resource/css/home.css" type="text/css">
<script type="text/javascript">
function updateTodo(num) {		
	var q = "todoNum="+num;
	var url = "<%=cp%>/main/update?" + q;
	
	if(confirm("할 일을 마치셨습니까? ")){
	location.href=url;
	}
	}

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
		
		out += "	<tr>";
		out += "		<td style='width: 75%; padding: 10px; border-bottom: 2px solid #9565A4;'>";
		out += "			<input type='text' name='content' style='border: none;' required='required'>";
		out += "		</td>";
		out += "		<td style='font-size: 16px; text-align: center; border: none;'>";
		out += "			<button type='submit' style='background: none; border: none; color: #2E2E2E;'><i class='fas fa-check'></i></button>";
		out += "			<button type='button' onclick='deleteTodo(${dto.todoNum});' style='background: none; border: none;'>";
		out += "				<i class='fas fa-trash-alt' style='color: #2E2E2E;''></i></button>";
		out += "		</td>";
		out += "	</tr>";
	
	   var $table = $(".todoT");
	   
	   var length = $(".todoT tr").length;
	   
       
       if(length > 4) {
    	   return;
       }

       $(".todoT").append(out);
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
	
// 일정 리스트
	$(function(){							
		calendar = $("#schedule-list").fullCalendar({						
		timeZone: 'UTC',							
		defaultView: 'listDay',							
		// customize the button names,							
		// otherwise they'd all just say "list"							
 		views: {							
		listDay: { buttonText: 'listday' }							
		},	 			
		
		locale:'ko',							
		events: function(start, end, timezone, callback){							
				// 캘린더가 처음 실행되거나 월이 변경되면				
				var startDate=start.format("YYYY-MM-DD");				
				var endDate=end.format("YYYY-MM-DD");				
								
				var url="<%=cp%>/main/month";				
				var query="start="+startDate+"&end="+endDate+"&group="+group+"&tmp="+new Date().getTime();				
								
				var fn = function(data){				
					var events = eval(data.list);			
					callback(events);			
				};				
								
			ajaxJSON(url, "post", query, fn);					
			}					
	});	
});
							
//위클리							
							
//start:2016-01-01 => 2016-01-01 일정							
//start:2016-01-01, end:2016-01-02 => 2016-01-01 일정							
//start:2016-01-01, end:2016-01-03 => 2016-01-01 ~ 2016-01-02 일정							
$(function() {							
		calendar = $("#weekcalendar").fullCalendar({					
			height:220,	
			header: {				
			left   : 'none'				
			},				
			defaultView: 'basicWeek'				
			,				
			locale: 'ko',				
			select: function(start, end, allDay) {				
				// start, end : moment 객체			
				// 일정하나를 선택하는 경우 종일일정인경우 end는 start 보다 1일이 크다.			
				//  캘런더에 start<=일정날짜또는시간<end 까지 표시함			
							
			},				
			events: function(start, end, timezone, callback){				
				// 캘린더가 처음 실행되거나 월이 변경되면			
				var startDate=start.format("YYYY-MM-DD");			
				var endDate=end.format("YYYY-MM-DD");			
							
				var url="<%=cp%>/main/month";			
				var query="start="+startDate+"&end="+endDate+"&group="+group+"&tmp="+new Date().getTime();							
							
				var fn = function(data){						
					var events = eval(data.list);					
					callback(events);				
				};						
							
			ajaxJSON(url, "post", query, fn);											
			}			
		});					
});	

</script>

<script>
$(function(){
	var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+"Seoul"+"&appid="+"92014bb042cf34f71371c60e82477360";
	
	$.ajax({
	    url: apiURI,
	    dataType: "json",
	    type: "GET",
	    async: "false",
	    success: function(resp) {
	        console.log(resp);
	        console.log("현재온도 : "+ (resp.main.temp- 273.15) );
	        console.log("날씨 : "+ resp.weather[0].main );
	        console.log("날씨 이미지 : "+ resp.weather[0].icon );
	        console.log("바람   : "+ resp.wind.speed );
	        console.log("상세날씨설명 : "+ resp.weather[0].description );
	        console.log("현재습도 : "+ resp.main.humidity);
	        console.log("구름  : "+ (resp.clouds.all) +"%" ); 
	        
	        var temp = Math.floor(resp.main.temp- 273.15);
	        var wcondition = resp.weather[0].main; 	        
	    	var out = "";
	    	var wicon = "";
			
			 if(wcondition=='Clouds') {
		        	wicon = "<i class='fas fa-cloud'></i>";
		        } else if(wcondition=='Clear') {
		        	wicon = "<i class='fas fa-sun'></i>";
		        } else if(wcondition=='Snow') {
		        	wicon = "<i class='fas fa-snowflake'></i>";
		        } else if(wcondition=='Rain') {
		        	wicon = "<i class='fas fa-cloud-showers-heavy'></i>";
		        } else if(wcondition=='Thunderstorm') {
		        	wicon = "<i class='fas fa-bolt'></i>";	
		        } else if(wcondition=='Drizzle') {
		        	wicon = "<i class='fas fa-cloud-sun'></i>";
		        } else if(wcondition=='Atmosphere') {
		        	wicon = "<i class='fas fa-smog'></i>";
		        }			
			
			out += "<table style='width: 90%; border: none; padding: 0px; border-spacing: 0px;'>";
			out += "<tr>";
			out += "	<td rowspan='2' style='text-align: right; width: 50%; font-size: 70px;'>" + wicon + "</td>";
			out += "	<td style='text-align: left; font-size: 30px; padding-left: 15px;'><i class='fas fa-temperature-high'></i>"  + temp + "°C" + "</td>";
		    out += "</tr>";
			out += "<tr>";
			out += "	<td style='text-align: left; font-size: 15px; font-style: italic; padding-left: 15px;'>" + "Seoul , KR" + "</td>";
			out += "</tr>";
			out += "	<td class='lastTd' colspan='2' style='text-align: center; font-size: 18px;  font-weight: bold;'>" 
			out += "		<i class='fas fa-wind'></i> " +  resp.wind.speed + "&nbsp;&nbsp;&nbsp;<i class='fas fa-tint'></i> " + resp.main.humidity;
			out += "		&nbsp;&nbsp;<i class='fas fa-umbrella'></i> " + (resp.clouds.all) + "%";
			out += "	</td>";
 		 	out += "</tr>";
			out += "</table>";

			
			$("#content-weather").append(out);
	    }
	});

	
});
</script>

<!-- 오늘의한마디 -->
<script type="text/javascript">
var pageNo=1;
var totalPage=1;

function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
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
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/talk/list";
	var query="pageNo="+page;
	
	var fn = function(data){
		printTalk(data);
	};
	
	ajaxJSON(url, "get", query, fn);		
}

$(function(){
	$(window).scroll(function(){
		if($(window).scrollTop()+50>=$(document).height()-$(window).height()) {
			if(pageNo<totalPage) {
				++pageNo;
				listPage(pageNo);
			}
		}
	});
});



function printTalk(data) {
	var uid="${sessionScope.employee.empNo}";
	var dataCount = data.dataCount;
	pageNo=data.pageNo;
	page=data.page;
	totalPage = data.total_page;
	
	var out="";
	if(dataCount!=0) {
		for(var idx=0; idx<data.list.length; idx++) {
			var talkNum=data.list[idx].talkNum;
			var name=data.list[idx].name;
			var writer=data.list[idx].writer;
			var content=data.list[idx].content;
			var created=data.list[idx].created;
			var image=data.list[idx].imageFilename;
			
			out+="    <tr height='40'>";
			if(image!=null){
				out+="	<td style='font-size:16px; padding-top:10px'><img src='<%=cp%>/uploads/profile/"+image+"' style='width: 36px; height: 36px; margin: 0 5px 0 5px; border-radius: 18px; vertical-align:middle;'><a class='nameDropdown'>"+name+"</a>";
				out+="	&nbsp;<i style='color:#F5A9A9' class='far fa-comment-dots'></i>&nbsp;&nbsp;"+content+"</td>";			
			} else {
				out+=" <td style='font-size:16px; line-height:35px;'><i class='far fa-user-circle' style='margin: 0 5px 0 5px ;'></i>"+name+"<i class='far fa-comment-dots'></i>"+content+"</td>";
			}			
			out+="    </tr>";
			out+="    <tr style='height: 40px; border-bottom:1px solid #cccccc ; margin-bottom:10px' >";
			out+="      <td  align='right' style='padding-right: 5px; border-left:none; color:#ABB2B9'>" + created;
			if(uid==writer || uid=="10003") {
				out+=" | <a  class='talkBtn' onclick='deleteTalk(\""+talkNum+"\", \""+page+"\");'>삭제</a></td>" ;
			}
			out+="    </tr>";
		}
		
		$("#listTalkBody").append(out);
		
		if(! checkScrollBar()) { // checkScrollBar() 함수는 util-jquery.js 에 존재
			if(pageNo<totalPage) {
				++pageNo;
				listPage(pageNo);
			}
		}
	}
}

function sendTalk() {
	if(! $.trim($("#content").val()) ) {
		$("#content").focus();
		return;
	}
	
	var url="<%=cp%>/talk/insert";
	var query=$("form[name=talkForm]").serialize();
	
	var fn = function(data){
		$("#content").val("");
		
		$("#listTalkBody").empty();
		pageNo=1;
		listPage(1);
	};
	
	ajaxJSON(url, "post", query, fn);
}

function deleteTalk(talkNum, page) {
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/talk/delete";
		var query="talkNum="+talkNum;
		
		var fn = function(data){
			// var state=data.state;
			$("#listTalkBody").empty();
			pageNo=1;
			listPage(1);
		};
		
		ajaxJSON(url, "post", query, fn);
	}
}




</script>



</head>
<body>

<div class="container">
	<div class="body-container">

	<div class="nav-left">
		<div class="container-left" style="width: 17%; height: 860px;">
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
						<td style="width: 79%; padding: 10px; padding-left: 5px; padding-right: 0px; border-bottom: 2px solid #9565A4;">						
						<div class="todoContent">						
												
							<c:if test="${dto.checked == 1}">						
								<i class="fas fa-clipboard-check" style="font-size: 18px;"></i> &nbsp;						
								<input type="text" name="content" value="${dto.content}" style="border: none; text-decoration: line-through;" required="required" disabled="disabled">						
							</c:if>	
												
							<c:if test="${dto.checked != 1}">						
								<button type="button" style="background: none; border: none;" onclick="updateTodo(${dto.todoNum});"><i class="fas fa-clipboard-check" style="font-size: 18px;"></i></button> &nbsp;						
								<input type="text" name="content" value="${dto.content}" style="border: none;" required="required" disabled="disabled">						
							</c:if>	
												
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
	
		
	<div class="nav-center">
		<div class="content-top">
			<div class="content-schedule" >
				<div  id="weekcalendar" class="weekcalendar"></div>
			</div>
			<div class="schedule-list">
				<div class="sl-title"> 오늘의 일정 
					<a href="<%=cp%>/scheduler/scheduler"><i class="fas fa-plus"></i></a></div>
				<div id="schedule-list"> </div>			
			</div>
		</div>
		
		<div class="content-bottom">
			<div class="content-todayTalk" >
				<div class="talk-container" >
				    <div class="body-title">
				        <h3><i class="far fa-edit"></i> TODAY TALK </h3>
				    </div>
				    <div>
			    		<form name="talkForm" method="post" action="">
			           		<div class="talk-write" align="center" >
			                	<div style="padding: 10px 0 10px 0; float: left">
			                       <textarea name="content" id="content" class="boxTF" style="display:block; width:460px; height:40px; padding: 6px 12px; box-sizing:border-box; resize: none;" required="required" placeholder="오늘의 한마디를 입력하세요..."></textarea>
			                 	</div>
			                 	<div style="text-align: right; padding-top: 10px;float: left;">
			                      <a class="talkBtn" onclick="sendTalk();" ><i class="fas fa-chevron-circle-up"></i> </a>
			                 	</div>           
			          	 	</div>
			           </form>      	          
				          <div id="listTalk"  style="height: 500px; overflow: auto; clear: both; background: white">
				           	<table style='width: 95%; margin: 10px auto 10px; border-spacing: 0px;  border-collapse: collapse;'>                   	           
					         <tbody id="listTalkBody"></tbody>
					        </table>
				          </div>                      
 	 				</div>	 
				</div>   
			</div>
			<div class="content-right">
				<div class="content-buddy" >
					<ul >
						<li>쪼옥지 </li>
					</ul>
				</div>
				
					<div class="content-notice" >
						<p> <i class="fas fa-bullhorn"></i> 공지사항 </p>
						<table>
							<c:forEach var="dto" items="${nlist}" begin="0" end="5">
							  <tr align="center"> 
							      <td align="left" style="padding-left: 10px; width: 60%;">
							           <a href="${noticeUrl}&noticeNum=${dto.noticeNum}">공지 :: ${dto.title}</a>
							      </td>
							  </tr>
							</c:forEach>
							  <tr>
							  	<td class="moreTD"> <a href="<%=cp%>/notice/list"> <i class="fas fa-location-arrow"></i> 더보기 </a> </td>
							  </tr>
						 </table>
					</div>
					<div class="content-news">
						<p> <i class="fas fa-newspaper"></i> 사내소식  </p>
					<table>
						<c:forEach var="dto" items="${nwlist}" begin="0" end="5">
						  <tr align="center"> 
				     		 <td align="left" style="padding-left: 10px;">
				     		 	 <c:if test="${dto.nType=='결혼'}">
				       		   		 <a href="${newsUrl}&newsNum=${dto.newsNum}"> <i class="fas fa-heart"></i>&nbsp;&nbsp;::&nbsp;${dto.title}</a>
				     		 	 </c:if>
				     		 	 <c:if test="${dto.nType=='부고'}">
				       		   		 <a href="${newsUrl}&newsNum=${dto.newsNum}"> <i class="fas fa-ribbon"></i>&nbsp;&nbsp;:: ${dto.title}</a>
				     		 	 </c:if>
				     		 	 <c:if test="${dto.nType=='회사소식'}">
				       		   		 <a href="${newsUrl}&newsNum=${dto.newsNum}"> <i class="fas fa-building"></i>&nbsp;&nbsp;:: ${dto.title}</a>
				     		 	 </c:if>
				     		 	 <c:if test="${dto.nType=='출산'}">
				       		   		 <a href="${newsUrl}&newsNum=${dto.newsNum}"> <i class="fas fa-baby"></i>&nbsp;&nbsp;:: ${dto.title}</a>
				     		 	 </c:if>
				     		 	 <c:if test="${dto.nType=='승진'}">
				       		   		 <a href="${newsUrl}&newsNum=${dto.newsNum}"> <i class="fas fa-level-up-alt"></i>&nbsp;&nbsp;:: ${dto.title}</a>
				     		 	 </c:if>
				     		 	 <c:if test="${dto.nType=='기타'}">																		
									<a href="${newsUrl}&newsNum=${dto.newsNum}"> <i class="fas fa-asterisk"></i>&nbsp;&nbsp;:: ${dto.title}</a>										
								 </c:if>
				     		 </td>
				 		 </tr>
				 		 <input type="hidden" value="${dto.nCode}">
						</c:forEach>
						 <tr>
							  	<td class="moreTD"> <a href="<%=cp%>/news/list"> <i class="fas fa-location-arrow"></i> 더보기 </a> </td>
						</tr>
					</table>
					</div>				
			</div>
		</div>			
	</div>
	
	<div class="nav-right">
			<div class="content-date">
				<ul>
					<li id="clockkk"></li>
				</ul>
			</div>
			<div class="content-weather">	
				    <div id="content-weather"></div>
			</div>	
			<div class="mini-box">
				<div class="mini-box-div1"> <a href="<%=cp%>/privateAddr/privateAddr"><span><i class="far fa-id-badge"></i></span> &nbsp;연락처 추가 </a></div>
				<div class="mini-box-div2"> <span><i class="fas fa-comments"></i></span> &nbsp;채팅 </div>
				<div class="mini-box-div1"> <span><i class="fab fa-digital-ocean"></i></span> &nbsp;다른거 </div>
				<div class="mini-box-div2"> <a href="<%=cp%>/sign/created"><span><i class="fas fa-signature"></i></span> &nbsp;전자 결재</a> </div>
			</div>		
	</div> 	
	
	
</div>
</div>
</body>
</html>