<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">


function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		/* , beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    } */
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		success:function(data){
			$(selector).html(data);
		},
		error:function(e){
			console.log(e.responseText);
		}
	});
}

/*====================================================*/
$(function() {
	$("#listSelect").change(function() {
		var url = "<%=cp%>/sign/search";
		
		var option = $("#listSelect option:selected").val();
		
		if(option==0){
			return;
		}
		var query = "option="+ option;
		
		$("#signForm").css("border", "1px solid black");
		
		ajaxHTML(url, "GET", query, "#signForm");
	});
});

function check() {
	var f = document.inputForm;
	
	
	var str = f.ssubject.value;
	
	if(!str){
		alert("제목을 입력하세요.");
		f.ssubject.focus();
		return false;
	}
	
	str = f.scontent.value;
	if(!str || str == "<p>&nbsp;</p>"){
		alert("내용을 입력하세요.");
		f.scontent.focus();
		return false;
	}
	var option = $("#listSelect option:selected").val();
	f.action = "<%=cp%>/sign/created?option="+option;
	f.submit();
}

$(function() {
	$("body").on("click", "#btnLine", function(){
		var value = $(this).closest("div").find("input[name=lineDivChild]").val();
		var $btn = $(this);
		$("#lineModal-dialog").dialog({
			modal : true,
			width : 600,
			title : '결제라인',
			open : function() {
			},
			close : function(event, ui) {
					var empNo = $("#listTable input[name=cb]:checked").val();
				$(function() {
					var dType = $("#listTable input[name=cb]:checked").closest("td").next().children("input[name=hDType]").val();
					var pType = $("#listTable input[name=cb]:checked").closest("td").next().next().children("input[name=hPType]").val();
					var tdName = $("#listTable input[name=cb]:checked").closest("td").next().next().next().children("input[name=hName]").val();
					$btn.closest("table").find(".typeTd").append("<span>"+ dType + " / " + pType + "</span>");
					$btn.closest("table").find(".nameTd").append("<span>"+ tdName + "</span>");
					
					$btn.closest("td").find("input").val(empNo);
				});
			}
		});
	});
	
	$("body").on("click", "#btnLineSelectOk", function(){
		$('#lineModal-dialog').dialog("close");
	});
	
	
});

</script>
<div>
	<span>테이블마다의 이름이 들어간다</span>
</div>


<div id="listBody" style="margin-left: 500px; width: 1000px;">
	<select id="listSelect">
		<option id="selectOption" value="0">::선택::</option>
		<option id="selectOption" value="1">1. 기안서</option>
		<option id="selectOption" value="2">2. 휴가 신청서</option>
		<option id="selectOption" value="3">3. 지출 결의서</option>
		<option id="selectOption" value="4">4. 외근 신청서</option>
		<option id="selectOption" value="5">5. 교육/훈련 신청서</option>
	</select>
</div>

<div id="signForm" style="width: 1000px; height:950px; margin-left: 500px;">

</div>
