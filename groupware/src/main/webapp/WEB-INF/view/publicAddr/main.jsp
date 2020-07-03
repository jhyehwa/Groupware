<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<link rel="stylesheet" href="<%=cp%>/resource/css/privateAddr.css" type="text/css">

<script type="text/javascript">	
	$(function(){
		listPage();
	});
	
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
	
	function ajaxHTML(url, type, query, selector) {
		$.ajax({
			type:type,
			url:url,
			data:query,
			success:function(data) {
				if($.trim(data)=="error") {
					listPage(1);
					return false;
				}	
				$(selector).html(data);
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
	
	//글리스트 및 페이징 처리
	function listPage() {
		
		var url="<%=cp%>/publicAddr/list";
		var query="";
	
		var selector = "#tab-content";
		
		ajaxHTML(url, "get", query, selector);
	}
</script>

<script>
	function searchList() {
		var url="<%=cp%>/publicAddr/list";
		var condition = $("select[name=condition]").val();
		var keyword = $("input[name=keyword]").val();
		
		console.log(condition);
		console.log(keyword);
		
		var query="condition=" + condition +"&keyword=" + keyword;
		console.log(query);
		
		var selector = "#tab-content";
		
		ajaxHTML(url, "get", query, selector);
	}
	
	$(function(){
		$("body").on("click", ".all", function(){
			var url = "<%=cp%>/publicAddr/list";
			var query = "";
			var selector = "#tab-content";
			
			ajaxHTML(url, "get", query, selector);
		});
	}); 

	$(function(){
		$("body").on("click", ".kor", function(){				
			// alert($(this).attr("data-kor"));
			
			var kor = $(this).attr("data-kor");
			var kor2 = $(this).closest("li").next().find("span").attr("data-kor");
			
			var url = "<%=cp%>/publicAddr/list";
			var query = "kor=" + encodeURIComponent(kor) + "&kor2=" + encodeURIComponent(kor2);
			var selector = "#tab-content";
			
			ajaxHTML(url, "get", query, selector);
		});
	});
</script>

<div class="container">
	<div id="list-container">
		<div id="body-title">
			<i class="fas fa-map-pin"> 공용주소록</i><span>&nbsp;&nbsp;${dataCount}개</span>
		</div>
	
		<div id="listBtnBox">
			<div id="listBtnBox-left">
				<button type="button" class="new-button3" onclick="javascript:location.href='<%=cp%>/publicAddr/main';"><i class="fas fa-undo-alt"></i></button>
			</div>
		
			<form name="searchForm" action="<%=cp%>/publicAddr/main" method="post">
				<div class="selectGroup-list">
					<select name="condition" class="selectBox-list">
						<option value="name" ${condition=="name"?"selected='selected'":""}>이름</option>
						<option value="birth" ${condition=="birth"?"selected='selected'":""}>생년월일</option>
						<option value="tel" ${condition=="tel"?"selected='selected'":""}>전화번호</option>
						<option value="dType" ${condition=="dType"?"selected='selected'":""}>부서</option>
						<option value="pType" ${condition=="pType"?"selected='selected'":""}>직위</option>
					</select>
				</div>
				<div id="searchBox">
					<p><input type="text" name="keyword" value="${keyword}">
					<button type="button" onclick="searchList()"><i class="fas fa-search"></i></button>
				</div>
			</form>
			
			<div id="tab-content"></div>
		</div>
	</div>
</div>