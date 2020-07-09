<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script>
	$(function(){
		function ajaxJSON(url, type, query, fn) {
			$.ajax({
				type:type,
				url:url,
				data:query,
				dataType:"JSON",
				success:function(data) {
					fn(data);
				},
				beforeSend:function(jqXHR) {
			        jqXHR.setRequestHeader("AJAX", true);
			    },
			    error:function(jqXHR) {
			    	if(jqXHR.status==403) {
			    		login();
			    		return false;
			    	}
			    	console.log(jqXHR.responseText);
			    }
			});
		}
		
		function mailAlert() {
			var url = "<%=cp%>/main/mainAlert";
			var fn = function(data) {
				var mailCnt = data.mailCnt;
				var stepCnt = data.stepCnt;
				
				var out = "<p>새로운메일" + mailCnt + "</p>";
				out += "<p>수신대기" + stepCnt + "</p>";
				
				$(".alertInfo").html(out);
			};
			var query = "";
			
			ajaxJSON(url, "post", query, fn);
		}
		mailAlert();
	});
	
	$(function(){
		$("body").on("click", "#headerAlert", function(){
			$(".alertTable").slideToggle();
		});
	});
	
	$(function(){
		$(".alertTable").hide();
	});
</script>

<div class="header-top">
	<div class="header-left">
		<p style="margin: 2px 0 0 20px;">
			<a href="<%=cp%>/main">
			<span>
			<img src="<%=cp%>/resource/images/logo3.png" width="120" height="60">
			</span>
			<!-- <span style="font-size: 28px; font-weight:900; color:GHOSTWHITE">AMPPER</span> -->
			</a>
		</p>
	</div>
	<div class="header-right">
		<div class="header-menu">
			<c:if test="${not empty sessionScope.employee}">
				<span style="color: white; margin-right: 10px; font-size: 15px;">${sessionScope.employee.name}님</span>
				<c:if test="${not empty sessionScope.employee.imageFilename}">
					<a href="<%=cp%>/profile/list"><img src="<%=cp%>/uploads/profile/${sessionScope.employee.imageFilename}" style="width: 36px; height: 36px; margin-right: 5px; border-radius: 18px;"></a>
				</c:if>
				<c:if test="${empty sessionScope.employee.imageFilename}">
					<a href="<%=cp%>"><i class="far fa-user-circle" style="margin-right: 5px;"></i></a> <!-- 프로필 -->
				</c:if>
				&nbsp;
			</c:if>
			
			<a href="#" id="headerAlert"><i class="far fa-bell" id="aa"></i></a> <!-- 알림 -->
			&nbsp;
			<a href="<%=cp%>/main"><i class="fas fa-bars"></i></a> <!-- 메뉴 -->
			&nbsp;
			<c:if test="${sessionScope.employee.rCode == 'admin'}">
				<a href="<%=cp%>/employee/list"><i class="fas fa-user-cog"></i></a> <!-- 관리자 -->
				&nbsp;
			</c:if>
			<c:if test="${not empty sessionScope.employee}">
				<a href="<%=cp%>/employee/logout"><i class="fas fa-sign-out-alt"></i></a>
			</c:if>
		</div>
	</div>
	
	<div class="alertTable" style="position: absolute; right: 0; top: 65px;">
		<div class="alertList" style="background: aqua; width: 200px; height: 200px;">
			<span class="alertInfo"></span>
		</div>
	</div>
</div>