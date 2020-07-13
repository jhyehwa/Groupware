<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/employeeList.css" type="text/css">

<script type="text/javascript">
	function searchList() {
		var f = document.searchForm;
		f.submit();
	}
</script>

<script>
	/* $(function(){
		listPage(1);
	}); */
	

	$(function(){
		$("#tab-office").addClass("active");
		listPage(1);

		$("ul.tabs li").click(function() {
			tab = $(this).attr("data-tab");
			
			$("ul.tabs li").each(function(){
				$(this).removeClass("active");
			});
			
			$("#tab-"+tab).addClass("active");
			
			
			listPage(1);
			/* reloadEmployee(); */
		});
	});
	
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
	
	function ajaxHTML(url, type, query, selector) {
		$.ajax({
			type:type
			,url:url
			,data:query
			,success:function(data) {
				if($.trim(data)=="error") {
					listPage(1);
					return false;
				}	
				$(selector).html(data);
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

	function listPage(page) {
		var $tab = $(".tabs .active");
		var tab = $tab.attr("data-tab");
		var url="<%=cp%>/employee/"+ tab +"/list";
		var query = "pageNo=" + page;
		var search = $('form[name=searchForm]').serialize();
		query = query + "&" + search;
		var selector = "#tab-content";
	
		ajaxHTML(url, "get", query, selector);
	}
		
	function searchList() {
		var f = document.searchForm;
		f.condition.value = $("#condition").val();
		f.keyword.value = $.trim($("#keyword").val());
	
		listPage(1);
	}

	//새로고침
	function reloadEmployee() {
		var f = document.employeeSearchForm;
		f.condition.value = "all";
		f.keyword.value = "";

		listPage(1);
	}
</script>

<div class="container">
	<div id="list-container">
		<div class="body-title">
			<h3><i class="fa fa-quote-left"> 사원 정보</i>&nbsp;|&nbsp;${dataCount}명</h3>
		</div>
	
		<div id="listBtnBox">
			<div id="listBtnBox-left">
				<button type="button" id="new-button1" class="listBtn" onclick="javascript:location.href='<%=cp%>/employee/employee';"><i class="fas fa-user-plus"></i></button>
				<button type="button" id="new-button2" class="listBtn" onclick="javascript:location.href='<%=cp%>/employee/list';"><i class="fas fa-undo-alt"></i></button>
			</div>
		
		
			<form name="searchForm" action="<%=cp%>/employee/list" method="post">
				<div class="selectGroup-list">
					<select name="condition" id="condition" class="selectBox-list">
						<option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
						<option value="enterDate" ${condition == "enterDate" ? "selected='selected'" : ""}>입사년도</option>								
						<option value="empNo" ${condition == "empNo" ? "selected='selected'" : "" }>사원번호</option>
						<option value="name" ${condition == "name" ? "selected='selected'" : ""}>이름</option>
						<option value="dType" ${condition == "dType" ? "selected='selected'" : ""}>부서</option>
						<option value="pType" ${condition == "pType" ? "selected='selected'" : ""}>직급</option>
					</select>
				</div>
				<div id="searchBox">
					<p><input type="text" name="keyword" id="keyword">
					<button type="button" onclick="searchList()"><i class="fas fa-search"></i></button>
					</p>
				</div>
			</form>
			
			<div id="container-list">
				<div style="background: yellow; float: left; list-style: none;">
						<ul class="tabs">
							<li id="tab-office" data-tab="office">재직</li>
							<li id="tab-leave" data-tab="leave">퇴사</li>
						</ul>
					</div>
								
				<div id="tab-content"></div>
			</div>
		
			<form name="employeeSearchForm" method="post">
				<input type="hidden" name="condition" value="all">
				<input type="hidden" name="keyword" value="">
			</form>
		</div>
	</div>
</div>