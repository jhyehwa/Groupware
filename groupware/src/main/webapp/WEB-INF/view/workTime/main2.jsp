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

$(window).load(function(){
	
	var msg = "${msg}";
	
	if(msg == 'no'){
		alert("오늘출근 하셨습니다.");
	}
});


$("body").on("click", ".workingBtn", function(){
	var val = $(this).data("val");
	var empNo = $("input[name=empNo]").val();
	
	if(val == 'home'){
		var now = new Date();
		nowMin = now.getHours();
		if(nowMin < 12){
			alert("퇴근시간이 아닙니다.");
			return;
		}
	}
	
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

</script>

<div class="container">
	<div class="board-container">
		<div class="board-title" style="font-size: 18px;">
            <h3>♬ 근태관리 </h3>
        </div>
		
			<div class="board-profile" style="width: 20%;">
				<div class="choiceStatus">
					<input type="hidden" name="empNo" value="${sessionScope.employee.empNo}">
					<input type="hidden" name="msg" value="${msg}">
		 				<!-- 근무 상태 변경 :) -->
						<table>
							<tr>
								<td>
									<button class="workingBtn" data-val="work" ${wk.clockIn==null ? '' : 'disabled="disabled"' }>
										<span>출근</span>
									</button>
								</td>
								<td>
									<button class="workingBtn" data-val="home" ${wk.clockOut==null ? '' : 'disabled="disabled"' } >
										<span>퇴근</span>
									</button>
								</td>
							</tr>
						</table>
				</div>
			</div>
		
			<div class="board-profile2" style="width: 50%">
				<!-- 출퇴근 연장근무 조퇴 등등 선택사항 + 현시간 :> -->
				<script type="text/javascript">
				function printTime(){
					var clock = document.getElementById("currTime");
					var curr = document.getElementById("curr");
					var now = new Date();
					
					clock.innerText = now.getFullYear() + "년" + (now.getMonth()+1) + "월" + now.getDate() + "일" + now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";
					curr.innerText = now.getFullYear() + "년" + (now.getMonth()+1) + "월" + now.getDate() + "일" + now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";
					setTimeout("printTime()", 1000);
				}
	
				window.onload = function(){
					printTime();
				}
				</script>
				<div><span id="currTime" class="currTime">현재시간 :)</span></div>
				<div class="status">
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
				</div>
			</div>
			
			<div class="board-statMemo" style="width: 30%">
				<!-- 이번주 근태 기록 :] -->
				<span>주중 근태 기록 :]</span>
				<div class="statMemo">
					<table>
						<tr>
							<td rowspan="2" style="width: 50px;">요일</td>
							<td style="width: 70px;">출근</td>
							<td style="width: 210px;">{출근 시간}</td>
							<td>근태 상태</td>
						</tr>
						<tr>
							<td>퇴근</td>
							<td>{퇴근 시간}</td>
							<td>{근태 상태}</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="board-detailed" style="width: 65%">
			  	<span>근태 기록 월별 정리 :}</span>
				<div class="detailed">
				<span>월 넘기기</span>
					<table>
						<tr>
							<td style="width: 20px;">일자</td>
							<td style="width: 70px;">출근</td>
							<td style="width: 70px;">퇴근</td>
							<td style="width: 70px;">근태 현황</td>
							<td style="width: 70px;">비고</td>
						</tr>
						<c:forEach var="dto" items="${monthList}" >
							<tr>
								<td>${dto.workDate}</td>
								<td>
									<c:if test="${dto.out1 != null}">
										<span>${dto.clockIn}[외근]</span>
									</c:if>
									<c:if test="${dto.out1 == null}">
										<span>${dto.clockIn}</span>
									</c:if>
								</td>
								<td>
								
								<c:if test="${dto.out2 != null }">
										<span>${dto.clockOut}[외근]</span>
									</c:if>
									<c:if test="${dto.out2 == null}">
										<span>${dto.clockOut}</span>
									</c:if>
								</td>
								<td>${dto.workCode}</td>
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
				</div>
				
				<div class="detailedMonth">
					<span>지각 : 횟수</span>
					<span>결근 : 횟수</span>
					<span>연차 : 횟수</span>
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