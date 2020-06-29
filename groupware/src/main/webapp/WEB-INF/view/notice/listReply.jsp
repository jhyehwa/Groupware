<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp=request.getContextPath();
%>

<table>
	<thead id='listReplyHeader' style="margin: 20px auto 0px;">
	</thead>
	

	<tbody id='listReplyBody'>
	<c:forEach var="vo" items="${listReply}">
		<tr height='35' style='background: white;'>
			<td class="replyNameTd" >
				<span><b>${vo.name}</b></span>
			</td>
			<td class="replyNameTd" align='right'>
				<span>${vo.created}</span> |
			<%-- 	<c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.userId=='admin'}"> --%>
					<span class="deleteReply" style="cursor: pointer;" data-replyNum='${vo.replyNum}' data-pageNo='${pageNo}'>삭제</span>
			<%-- 	</c:if> --%>
		<%-- 		<c:if test="${sessionScope.member.userId!=vo.userId || sessionScope.member.userId!='admin'}"> --%>
					<span class="notifyReply">신고</span>
			<%-- 	</c:if> --%>
			</td>
		</tr>
		<tr>
			<td class="replyContentTd" colspan='2' valign='top'>
				${vo.content}
			</td>
		</tr>
	</c:forEach>
	</tbody>

	<tfoot id='listReplyFooter'>
		<tr height='40' align="center">
			<td colspan='2' >
				${paging}
			</td>
		</tr>
	</tfoot>
</table>
