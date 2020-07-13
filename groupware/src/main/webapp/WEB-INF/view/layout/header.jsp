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
		
		function mainAlert() {
			var url = "<%=cp%>/main/mainAlert";
			var fn = function(data) {
				var mainCnt = data.mailCnt + data.stepCnt + data.newsCnt;
				
				var alertCnt = mainCnt;
				$("#mainCnt").html(alertCnt);
				
				var mailCnt = data.mailCnt;
				var stepCnt = data.stepCnt;
				var newsCnt = data.newsCnt;
				
				var out = "<p id='allAlert' style='margin-left: 10px; padding-top: 10px; font-size: 15px; margin-right: 10px; font-weight: bold; border-bottom: 1px solid #ccc; padding-bottom: 10px;'>전체 알림</p>";
				
				
				out += "<p id='mailCnt'><a href='<%=cp%>/buddy/rlist'><i class='fas fa-square fa-stack-2x' style='color: #632A7E; text-align: left; margin-left: 15px; padding-top: 10px;'></i>";
				out += "<i class='fas fa-envelope-open-text fa-stack-1x fa-inverse' style='width: 50px; backgroud: white; text-align: left; color: white; position: relative; margin-left: 25px; margin-top: 20px;'>";
				out += "<span style='position: absolute; background: #FFE641; color: #585858; width: 20px; height: 20px; border-radius: 50%; font-size: 16px; line-height: 20px; margin-top: -15px; text-align: center;'>";
				out += + mailCnt + "</span></i></a>" + "<span style='font-size: 15px; margin-left: 0px;'>새로운 메일 " + "<span style='font-weight: 1000;'>" + mailCnt + " 개</span></span>" + "</p>";
				
				
				
				out += "<p id='stepCnt'><a href='<%=cp%>/sign/mainList'><i class='fas fa-square fa-stack-2x' style='color: #632A7E; text-align: left; margin-left: 15px; margin-top: 15px;'></i>";
				out += "<i class='fas fa-clock fa-stack-1x fa-inverse'  style='width: 50px; backgroud: white; text-align: left; color: white; position: relative; margin-left: 25px; margin-top: 27px;'>";
				out += "<span style='position: absolute; background: #FFE641; color: #585858; width: 20px; height: 20px; border-radius: 50%; font-size: 16px; line-height: 20px; margin-top: -15px; text-align: center;'>";
				out += + stepCnt + "</span></i></a>" + "<span style='font-size: 15px; margin-left: 0px;'>처리해야 할 결재 " + "<span style='font-weight: 1000;'>" + stepCnt + " 건</span></span>" + "</p>";
				
				
				out += "<p id='newsCnt'><a class='newsClick' href='<%=cp%>/news/list'><i class='fas fa-square fa-stack-2x' style='color: #632A7E; text-align: left; margin-left: 15px; margin-top: 15px;'></i>";
				out += "<i class='far fa-building fa-stack-1x fa-inverse' style='width: 50px; backgroud: white; text-align: left; color: white; position: relative; margin-left: 25px; margin-top: 27px;'>";
				out += "<span style='position: absolute; background: #FFE641; color: #585858; width: 20px; height: 20px; border-radius: 50%; font-size: 16px; line-height: 20px; margin-top: -15px; text-align: center;'>";
				out += + newsCnt + "</span></i></a>" + "<span style='font-size: 15px; margin-left: 0px;'>회사소식 " + "<span style='font-weight: 1000;'>" + newsCnt + " 건</span></span>" + "</p>";
				
				$(".alertInfo").html(out);
				
				$("#mailCnt").css("font-size","25px");
				$("#stepCnt").css("font-size","25px");
				$("#newsCnt").css("font-size", "25px");
				
				if(mainCnt == 0) {
					$("#mainCnt").hide();
				} else {
					$("#mainCnt").show();
				}
				
			};
			
			var query = "";
			
			ajaxJSON(url, "post", query, fn);
		}
		mainAlert();
	});
	
	$(function(){
		$("body").on("click", "#headerAlert", function(){
			$(".alertTable").slideToggle();
		});
	});
	
	$(function(){
		$(".alertTable").hide();
	});
	
	// 전체 메뉴
	$(function(){
		$("#aa").hide();
	});
	
	$(function(){
		$("body").on("click", "#hMenu", function(){
			$("#aa").slideToggle();
		});
	});
	
	$(function(){
		$("body").on("click", ".pullMenu", function(){
			$('dept1').slideDown(200);
		});
	});
</script>

<style>
.alertList {
	background-image: linear-gradient(to top, #cd9cf2 0%, #f6f3ff 100%);
}


</style>

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
		<div class="header-menu" style="position: relative;">
			<c:if test="${not empty sessionScope.employee}">
				<span style="color: white; font-size: 15px; position: relative; left: -50px;">${sessionScope.employee.name}님</span>
				<c:if test="${not empty sessionScope.employee.imageFilename}">
					<a href="<%=cp%>/profile/list"><img src="<%=cp%>/uploads/profile/${sessionScope.employee.imageFilename}" style="width: 36px; height: 36px; margin-right: 5px; border-radius: 18px; position: absolute; left: 20px; top: 15px;"></a>
				</c:if>
				<c:if test="${empty sessionScope.employee.imageFilename}">
					<a href="<%=cp%>"><i class="far fa-user-circle" style="margin-right: 5px;"></i></a> <!-- 프로필 -->
				</c:if>
				&nbsp;
			</c:if>
			
			<!-- 알림 -->
			<a href="#" id="headerAlert">
				<i class="far fa-bell" style='position: relative; margin-left: 10px; margin-top: 10px;'>
					<span id="mainCnt" style='position: absolute; top: -10px; right: -12px; background: #FFE641; color: #585858; width: 20px; height: 20px; border-radius: 50%; font-size: 16px; text-align: center; line-height: 20px;'></span>
				</i>
			</a>
			&nbsp;
			<a href="#" id="hMenu"><i class="fas fa-bars"></i></a> <!-- 메뉴 -->
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
	
	<!-- 알림창 -->
	<div class="alertTable" style="position: absolute; right: 30px; top: 65px;">
		<div class="alertList" style="width: 250px; height: 220px; position: relative; z-index: 2;">
			<span class="alertInfo"></span>
		</div>
	</div>
	
	<!-- header 메뉴 -->
	<div id="aa" style="background: yellow; width: 1920px; top: 65px; position: absolute; z-index: 2;">
		<div style="position: relative; background: aqua; width: 1520px; height: 300px; margin: 0px auto;" class="pullMenu">
			<ul class="dept1" style="background: lime; height: 300px;">	
				<li class="pullTitle" style="float: left; width: 217px; background: orange;">
				<span style="font-size: 20px; width: 217px; background: skyblue;">주소록</span>
					<ul class="submenu">
						<li><i class="fas fa-briefcase"><a href="<%=cp%>/publicAddr/main">공용주소록</a></i></li>
						<li><i class="far fa-address-book"><a href="<%=cp%>/privateAddr/main">개인주소록</a></i></li>
					</ul>
				</li>

				<li class="pullTitle" style="float: left; width: 217px; background: fuchsia;">
				<span>메일</span>
					<ul class="submenu">
						<li><i class="fas fa-envelope"><a href="<%=cp%>/buddy/rlist">메일</a></i></li>
					</ul>
				</li>

				<li class="pullTitle" style="float: left; width: 217px; background: gray;">
				<span>전자결재</span>
					<ul class="submenu">						
						<li><i class="fas fa-file-signature"><a href="<%=cp%>/sign/mainList">전자결재</a></i></li>
					</ul>
				</li>

				<li class="pullTitle" style="float: left; width: 217px; background: red;">
				<span>캘린더</span>
					<ul class="submenu">
						<li><i class="fas fa-calendar-alt"><a href="<%=cp%>/scheduler/scheduler">일정</a></i></li>
					</ul>
				</li>

				<li class="pullTitle" style="float: left; width: 217px; background: silver;">
				<span>게시판</span>
					<ul class="submenu">
						<li><i class="fas fa-users"><a href="<%=cp%>/community/list">커뮤니티</a></i></li>
						<li><a href="<%=cp%>/notice/list">공지</a></li>
						<li><a href="<%=cp%>/news/list">News</a></li>
						<li><a href="<%=cp%>/food/month">식단표</a></li>
					</ul>
				</li>
			
				<li class="pullTitle" style="float: left; width: 217px; background: gold;">
				<span>근태</span>
					<ul class="submenu">
						<li><i class="fas fa-user-clock"><a href="<%=cp%>/workTime/main">근태관리</a></i></li>
					</ul>
				</li>
			
				<li class="pullTitle" style="float: left; width: 217px; background: olive;">
				<span>자료실</span>
					<ul class="submenu">
						<li><i class="fas fa-download"><a href="<%=cp%>/data/list">자료실</a></i></li>
					</ul>
				</li>
			</ul>
		</div>	
	</div>
</div>