<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


<script type="text/javascript">

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

$(function() {
	window.onload = function() {
		
		alert($("input[name=mode]").val());
		<%-- 
		var url = "<%=cp%>/sign/search";
		
		var option = $("#listSelect option:selected").val();
		
		if(option==0){
			return;
		}
		var query = "option="+ option;
		
		$("#signForm").css("border", "1px solid black");
		
		ajaxHTML(url, "GET", query, "#signForm"); --%>
	};
});


</script>

<input type="hidden" value="${mode}" name="mode">
<div id="signForm" style="width: 1000px; height:950px; margin-left: 500px;"></div>
