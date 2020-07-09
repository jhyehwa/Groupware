<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/workTime.css" type="text/css">
<script type="text/javascript"	src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript"	src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>

<script type="text/javascript">

function ajaxGET(url, type, query) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		error:function(e){
			console.log(e.responseText);
		}
	});
}


$("body").on("click", ".workingBtn", function(){
	var val = $(this).data("val");
	var empNo = $("input[name=empNo]").val();
	
	/* if(val == 'home'){
		var now = new Date();
		nowMin = now.getHours();
		if(nowMin < 12){
			alert("퇴근시간이 아닙니다.");
			return;
		}
	} */
	
	$(".modal").dialog({
		modal : true,
		width : 500,
		height : 100,
		position : {my:"center top", at:"center top"},
		show : "fade",
		resizable : false,
		open : function(){
			$("form[name=sendForm]").append("<input type='hidden' id='empNo' name='empNo' value='" + empNo + "'>");
			$("form[name=sendForm]").append("<input type='hidden' id='val' name='val' value='" + val + "'>");
			
			$(".ui-draggable .ui-dialog-titlebar").css("background", "white");
			$(".ui-draggable .ui-dialog-titlebar").css("border", "white");
			
		},close : function(){
			
		}
	});
});

$("body").on("click", ".restBtn", function(){
	
	$(".vation").dialog({
		modal : true,
		width : 500,
		height : 100,
		position : {my:"center top", at:"center top"},
		show : "fade",
		resizable : false,
		open : function(){
			$(".ui-draggable .ui-dialog-titlebar").css("background", "white");
			$(".ui-draggable .ui-dialog-titlebar").css("border", "white");
			
		},close : function(){
			
		}
	});
});

function send(){
	var f = document.sendForm;
	
	var val = f.val.value;
	
	f.action="<%=cp%>/workTime/workOrHome";
	f.submit();
}

function sendOut(){
	var f = document.sendForm;
	

	var val = f.val.value;
	
	var out = "out";
	
	f.action="<%=cp%>/workTime/out?out="+out;
	f.submit();
}

function updateMemo(){
	var f = document.updateForm;
	
	var str = f.other.value;
	
	if(!str){
		alert("사유를 입력하세요.");
		f.other.focus();
		return;
	}
	f.action="<%=cp%>/workTime/update";
	f.submit();
}

function vacation(){
	var f = document.vacationForm;
	
	var str = f.startDay.value;
	if(!str){
		alert("시작 날짜를 지정하세요.");
		f.startDay.focus();
		return;
	}
	
	var str = f.endDay.value;
	if(!str){
		alert("종료 날짜를 지정하세요.");
		f.endDay.focus();
		return;
	}
	
	f.action="<%=cp%>/workTime/vacation";
	
	f.submit();
}
</script>

<div class="container">
	 <div class="board-container" style="margin-left: 200px;">
        <div class="body-title" style="font-size: 18px;">
            <h3> ♬ 근태관리 </h3>
        </div>   

        <div class="board-body" style="float: left; width: 23%;">	      
				<input type="hidden" name="empNo" value="${sessionScope.employee.empNo}">
				<input type="hidden" name="msg" value="${msg}">
					
		 		<!-- 출퇴근 찍기 -->
				<div class="timeINOUT">				
					<p> <i class="fas fa-clock"></i> </p>
				
					<div class="timeBtn">
						<button class="workingBtn" data-val="work" ${wk.clockIn==null ? '' : 'disabled="disabled"' }>
							<i class="fas fa-walking"></i>&nbsp;<i class="fas fa-sign-in-alt"></i>
						</button>
						<span>|</span>	
						<button class="workingBtn" data-val="home" ${wk.clockOut==null ? '' : 'disabled="disabled"' } >
							<i class="fas fa-sign-out-alt"></i>&nbsp;<i class="fas fa-running"></i>
						</button>
					</div>
					<div class="timeWord">
						<p> 출근하기 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 퇴근하기 </p>					
					</div>
				
					<div class="board-statMemo" style="width: 100%;">	
						<table class="stateTable">
							<tr>
								<td class="stFtd" colspan="2">2020년 7월 9일</td>
							</tr>
							<tr>
								<td class="stStd" style="width:50%;">출근</td>
								<td class="stStd" style="width:50%;">퇴근</td>
							</tr>
							<tr>
								<td>${wk.clockIn}</td> 
								<td>${wk.clockOut}</td>
							</tr>
							<tr>
								<td>
								<c:if test="${msg == 'work'}">
									퇴근
								</c:if>
								<c:if test="${msg != 'work'}">
									정상 출근
								</c:if>
								</td> 
								<td>${wk.workCode}</td>
							</tr>
							<tr class="vacaiontTr">
								<td colspan="2" class="vacaiontTd">
									<button type="button" name="restBtn" class="restBtn"><i class="fas fa-plane-departure"></i>&nbsp;
									<span class="restSpan">연차사용</span></button>
								</td>
							</tr>
						</table>		
					</div>
				</div> 
		
			<!-- 	
				<div class="board-statMemo" style="width: 100%; background: yellow;">
				이번주 근태 기록 :]
				<h3 style="font-size: 18px;">| 주중 근태 기록 </h3>				
					<table class="stateTable">
						<tr>
							<td class="stFtd" style="width:15%;">요일</td>
							<td class="stFtd" style="width:15%;">출근</td>
							<td class="stFtd" style="width:45%;">퇴근</td>
							<td class="stFtd" style="width:25%;">근태 상태</td>
						</tr>
						<tr>
							<td>월요일</td>
							<td>09:00:00</td>
							<td>18:00:00</td>
							<td>정상</td>
						</tr>
					</table>		
				</div> -->
        </div>
        
        
        
        
        <!-- 출퇴근 연장근무 조퇴 등등 선택사항 + 현시간 :> -->
        <div class="board-body" style="width: 65%; float: left; margin-left: 45px; margin-top: 15px;" >        
			<script type="text/javascript">
			function printTime(){
				var clock = document.getElementById("currTime");
				var curr = document.getElementById("curr");
				var now = new Date();
					
				clock.innerText =  now.getFullYear() + "년 " + (now.getMonth()+1) + "월 " + now.getDate() + "일 " + "  " + now.getHours() + "시 " + now.getMinutes() + "분 " + now.getSeconds() + "초";
				curr.innerText = now.getFullYear() + "년 " + (now.getMonth()+1) + "월 " + now.getDate() + "일 " + now.getHours() + "시 " + now.getMinutes() + "분 " + now.getSeconds() + "초 ";
				setTimeout("printTime()", 1000);
			}
	
				window.onload = function(){
				printTime();
			}
			</script>
			
			<div id="currTime" class="currTime">
				<h3 style="font-size: 18px;"></h3>	
			</div>
				<%-- <div class="status" style="background: aqua;">
					<table>
						<tr>
							<td>${wk.workDate}</td>
						</tr>
						<tr>
							<td>출근 시각 : </td>
							<td>${wk.clockIn}</td>
							<td>출결 상태 : </td>
							<td>
								<c:if test="${msg == 'work'}">
									퇴근
								</c:if>
								<c:if test="${msg != 'work'}">
									출근
								</c:if>
							</td>
						</tr>
						<tr>
							<td>퇴근 시각 : </td>
							<td>${wk.clockOut}</td>
							<td>근태 상태</td>
							<td>${wk.workCode}</td>
						</tr>
					</table>
				</div> --%>
				
				<div class="board-detailed" style="width: 100%;">
			  		<h3 style="font-size: 20px;">| 월별 근태 기록  </h3>
	
					<table class="monthTable">
						<tr>
							<td class="mtFtd" style="width: 15px;">일자</td>
							<td class="mtFtd" style="width: 60px;">출근</td>
							<td class="mtFtd" style="width: 60px;">퇴근</td>
							<td class="mtFtd" style="width: 70px;">근태 현황</td>
							<td class="mtFtd" style="width: 25px;"> IP </td>
							<td class="mtFtd" style="width: 70px;">비고</td>
						</tr>
						<c:forEach var="dto" items="${monthList}" >
							<tr>
								<td>${dto.workDate}</td>
								<c:if test="${dto.workCode=='연차'}">
									<td>
										<span>-</span>
									</td>
								</c:if>
								<c:if test="${dto.workCode!='연차'}">
									<td>
										<c:if test="${dto.out1 != null}">
											<span>${dto.clockIn} [외근]</span>
										</c:if>
										<c:if test="${dto.out1 == null}">
											<span>${dto.clockIn}</span>
										</c:if>
									</td>
								</c:if>
								
								<c:if test="${dto.workCode=='연차'}">
									<td>
										<span>-</span>
									</td>
								</c:if>
								<c:if test="${dto.workCode!='연차'}">
								<td>
								<c:if test="${dto.out2 != null }">
										<span>${dto.clockOut} [외근]</span>
									</c:if>
									<c:if test="${dto.out2 == null}">
										<span>${dto.clockOut}</span>
									</c:if>
								</td>
								</c:if>
								<td>${dto.workCode}</td>
								<td>${dto.ipAddr}</td>
								<td>
									<c:if test="${dto.other == null}">
									<form method="post" id="updateForm" name="updateForm">
										<input type="text" name="other" id="other" class="workOther">
										<button type="button" name="otherBtn" onclick="updateMemo()">+</button>
									</form>
									</c:if>
									<c:if test="${dto.other != null}">
										${dto.other}
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
			
				
				<div class="detailedMonth">
					<span>지각 : ${codeB == null ? '0' : codeB}회 | </span>
					<span>결근 : ${codeC == null ? '0' : codeC}회 | </span>
					<span>연차 : ${codeG == null ? '0' : codeG}회 사용</span>
				</div>
			</div>
        </div>   
        
	</div>
</div>


<!-- 모달창 -->
<div id ="checking" class="modal"  style="width: 300px; height: 250px;
	display: none;">
	<div class="nowDate">
		<h3 id="curr">현재 시간을 출력해줄꺼야</h3>
	</div>
	<form method="POST" id="sendForm" name="sendForm">
		<button type="button" class="sendBtn" onclick="send();">확인</button>
		<button type="button" class="sendBtns" onclick="sendOut();">외근</button>
	</form>
</div>


<!-- 휴가 사용 -->
<div id ="vation" class="vation" style="width: 600px; height: 250px; display: none;">
	<form method="POST" id="vacationForm" name="vacationForm">
		<input type="Date" name="startDay"> ~
		<input type="Date" name="endDay">
		<button type="button" class="vacationBtn" onclick="vacation();">확인</button>
	</form>
</div>