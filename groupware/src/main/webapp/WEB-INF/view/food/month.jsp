<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
/* 모달대화상자 타이틀바 */
.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #EDA900;
	border-radius: 0px;
}
.help-block {
	margin-top: 3px; 
}

.titleDate {
	display: inline-block;
	font-weight: 600; 
	font-size: 19px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
	padding:2px 4px 4px;
	text-align:center;
	position: relative;
	top: 4px;
}
.btnDate {
	display: inline-block;
	font-size: 10px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
	color:#333333;
	padding:3px 5px 5px;
	border:1px solid #cccccc;
    background-color:#fff;
    text-align:center;
    cursor: pointer;
    border-radius:2px;
}


.textDate {
      font-weight: 500; cursor: pointer; font-size:20px; display: block;
      
}
.preMonthDate, .nextMonthDate {
      color:#aaaaaa;
}
.nowDate {
      width:30px;
	  height:30px;
      font-weight: 500; cursor: pointer; font-size:20px; display: block; color:#333333;

}
.nowDate:hover {
      width:30px;
	  height:30px;
      font-weight: 500; cursor: pointer; font-size:20px; display: block; background:#EDA900;
      border-radius: 15px;
}

.saturdayDate{
      width:30px;
	  height:30px;
      font-weight: 500; cursor: pointer; font-size:20px; display: block; color:#632A7E;
}

.saturdayDate .foodSubject {
	 background:#EEE0F9;
   opacity: 0.5;
}

.sundayDate{
       width:30px;
	  height:30px;
      font-weight: 500; cursor: pointer; font-size:20px; display: block; color:red;
}

.foodSubject {
   display:block;
   /*width:100%;*/
   width:110px;
   height:25px;
   line-height: 25px;
   margin:1.5px 0; 
   color:#333333;
   background:#EEE0F9;
   cursor: pointer;
   white-space:nowrap; overflow:hidden; text-overflow:ellipsis;
}

.foodBtn{
	color: #6E3C89;
	background:white;
	border:1px solid #6E3C89;
	border-top-left-radius: 5px; 
	border-bottom-left-radius: 5px; 
	border-top-right-radius: 5px; 
	border-bottom-right-radius: 5px; 
	padding:3px 3px;
}

.foodBtn:hover{ 
	color:white; 
	background-color: #6E3C89; 
}

#menuBtn{
	border: 1px solid #632A7E;
	border-radius: 5px;
	background: white;
	color:#632A7E;
	padding: 5px;

}

</style>
<script type="text/javascript">

function ajaxHTML(url, method, query, selector) {
	$.ajax({
		type: method, 
		url: url,
		data: query,
		success: function(data){
			$(selector).html(data);
		}, 
		beforeSend: function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		}, 
		error: function(jqXHR) {
			if(jqXHR.state==403) {		
				login(); 
				return false;
			} 			
			console.log(jqXHR.responseText);
		}
	});		
}

$(function(){
	$("#tab-month").addClass("active");
});

$(function(){
	var today="${today}";
	$("#largeCalendar .textDate").each(function (i) {
        var s=$(this).attr("data-date");
        if(s==today) {
        	$(this).parent().css("background", "#FFFDE6 ");
        }
    });
});


function changeDate(year, month) {
	var url="<%=cp%>/food/month?year="+year+"&month="+month;
	location.href=url;
}

// 스케쥴 등록 -----------------------
// 등록 대화상자 출력
<c:if test="${sessionScope.employee.empNo=='10001'}">

$(function(){
	$(".textDate").click(function(){
		// 폼 reset
		$("form[name=foodForm]").each(function(){
			this.reset();
		});
		
		var date=$(this).attr("data-date");
		date=date.substr(0,4)+"-"+date.substr(4,2)+"-"+date.substr(6,2);

		$("form[name=foodForm] input[name=created]").val(date);
		
		$("#form-created").datepicker({showMonthAfterYear:true});
		
		$("#form-created").datepicker("option", "defaultDate", date);
		
		$('#food-dialog').dialog({
			  modal: true,
			  height: 650,
			  width: 600,
			  title: '식단등록',
			  close: function(event, ui) {
			  }
		});

	});
});

// 등록
$(function(){
	$("#btnFoodSendOk").click(function(){

		if(! check()) {
			return false;
		}
		
		var query=$("form[name=foodForm]").serialize();
		var url="<%=cp%>/food/insert";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					var dd=$("#form-created").val().split("-");
					var y=dd[0];
					var m=dd[1];
					if(m.substr(0,1)=="0") 	m=m.substr(1,1);
					location.href="<%=cp%>/food/month?year="+y+"&month="+m;
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		location.href="<%=cp%>/login";
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	});
});

// 등록 대화상자 닫기
$(function(){
	$("#btnFoodSendCancel").click(function(){
		$('#food-dialog').dialog("close");
	});
});

</c:if>

// 등록내용 유효성 검사
function check() {
	if(! $("#form-subject").val()) {
		$("#form-subject").focus();
		return false;
	}

	if(! $("#form-created").val()) {
		$("#form-created").focus();
		alert("내용을 입력하세요");
		return false;
	}

	return true;
}



// 스케쥴 제목 클릭 -----------------------



$(function(){
	$(".foodSubject").click(function(){
		var selectDate = $(this).attr("data-date");
		var date=selectDate;
		date=date.substr(0,4)+"년"+date.substr(4,2)+"월"+date.substr(6,2);
		$('#food-detail').dialog({
			  modal: true,
			  height: 650,
			  width: 600,
			  title: date+'일의 식단',
			  
			  close: function(event, ui) {
			  },
			  open:function(){
					$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").remove();	// x버튼 바꿨음
					
					var url="<%=cp%>/food/listDate?selectDate="+selectDate;
					$("#food-detail").load(url);
					
				},
				buttons:{		//버튼추가!
					"확인":function(){
						$(this).dialog("close");
					}
				}
		});
	});
});

//식단상자 닫기
$(function(){
	$("#btnFoodDetail").click(function(){
		$('#food-detail').dialog("close");
	});
});


function deleteOk(num) {
	if(confirm("일정을 삭제 하시 겠습니까 ? ")) {
		var url="<%=cp%>/food/delete?foodNum="+num;
		location.href=url;
	}
}


</script>
<div class="container">	
	<div class="board-container" style="margin-left: 200px;">
	    <div class="body-title">
	        <h3> 냠냠냠</h3>
	    </div>
	    
    	<div class="board-body" style="float: left; width: 20%;">	      
	        <div style="margin: 30px 0 0 20px; ">
	        	<table >  	
		        	<tr>
		        		<td><button type="button" disabled="disabled" style="margin-left:55px; width: 100px; height: 100px; border-radius: 50px; background:#EEE0F9; border: none; color:#333333;" >오늘의메뉴</button></td>	        		
		        	</tr>
		        	
		        	<tr>
		        		<td style="padding: 10px 0 0 50px; ">${todayYear}년 ${todayMonth}월  ${todayDate}일 </td>
		        	</tr>
	        	</table>
	        	
	        	<c:if test="${list.size()==0}">
				<table style="width: 100%; margin-top:5px; border-spacing: 0px; border-collapse: collapse;">
					<tr height="35">
						<td align="center">등록된 식단이 없습니다.</td>
					</tr>
				</table>
				</c:if>
				
				
				<table style="width: 70%; margin-top:5px; border-spacing: 0px; border-collapse: collapse;">
				<c:forEach var="dto" items="${list}">
					<tr height="35" style="border-top: 1px solid #cccccc;">
						<td style="text-align: center; padding-left: 7px;">
							<p style="margin-top: 1px; margin-bottom: 1px; font-weight: 900;">
							<c:choose>
							    <c:when test="${dto.subject=='LUNCH'}">점심</c:when>
							    <c:when test="${dto.subject=='DINNER'}">저녁</c:when>
						    <c:otherwise>간식</c:otherwise>
						    </c:choose>
							</p>
						</td>
					</tr>
					<tr height="45" >
						<td valign="top" style="text-align: left; margin-top: 5px; padding-left: 10px;">
							<p style="margin: 15px 0 30px 0; text-align: center" >
								<span style="white-space: pre;">${dto.content}</span>
							</p>
						</td>
					</tr>
				</c:forEach>	
					
				</table>
	    	
	        </div>	       	       
        </div>

		   <div id="tab-content" style="padding-bottom:20px; float: left;"> 		   
		   		<table style="width: 840px; margin:0px auto; border-spacing: 0;" >
		   			<tr height="60">
		   			     <td width="200">&nbsp;</td>
		   			     <td align="center">
		   			         <span class="btnDate" onclick="changeDate(${todayYear}, ${todayMonth});">오늘</span>
		   			         <span class="btnDate" onclick="changeDate(${year}, ${month-1});">＜</span>
		   			         <span class="titleDate">${year}년 ${month}월</span>
		   			         <span class="btnDate" onclick="changeDate(${year}, ${month+1});">＞</span>
		   			     </td>
		   			     <td width="200">&nbsp;</td>
		   			</tr>
		   		</table>
		   		
			    <table id="largeCalendar" style="width: 840px; margin:10px auto;" >
					<tr align="center" height="30" bgcolor="#ffffff">
						<td width="120" style="color:#cccccc;">일</td>
						<td width="120">월</td>
						<td width="120">화</td>
						<td width="120">수</td>
						<td width="120">목</td>
						<td width="120">금</td>
						<td width="120" style="color:#cccccc;">토</td>
					</tr>

				<c:forEach var="row" items="${days}" >
						<tr align="center" height="120" valign="top">
							<c:forEach var="d" items="${row}">
								<td style="padding: 5px; box-sizing:border-box;">
									${d}
								</td>
							</c:forEach>
						</tr>
				</c:forEach>
			    </table>		   
		   </div>

    </div>


   <div id="food-dialog" class="modal" style="display: none;">
		<form name="foodForm">
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">분류</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select name="subject" id="form-subject" class="selectField">
			              <option value="LUNCH">점심</option>
			              <option value="DINNER">저녁</option>
			              <option value="SNACK">간식</option>
			          </select>
			        </p>
			        
			      </td>
			  </tr>			
			  
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">날짜</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="created" id="form-created" maxlength="10" class="boxTF" readonly="readonly" style="width: 25%; background: #ffffff;">
  			        </p>
			      </td>
			  </tr>

			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">내용</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <textarea name="content" id="form-content" class="boxTA" style="width:400px; height: 200px; resize: none;"></textarea>
			        </p>
			      </td>
			  </tr>
			  
			  <tr height="45">
			      <td align="center" colspan="2">
			        <button type="button" class="foodBtn" id="btnFoodSendOk">식단등록</button>
			        <button type="reset" class="foodBtn">다시입력</button>
			        <button type="button" class="foodBtn" id="btnFoodSendCancel">등록취소</button>
			      </td>
			  </tr>
			</table>
		</form>
    </div>
    
    
    <div id="food-detail"></div>
		
</div>    