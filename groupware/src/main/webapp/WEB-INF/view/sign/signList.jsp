<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<table style="margin-top: 20px;">
	<tr>
		<td align="left">&nbsp;</td>
		<td align="left"><h3>결재대기함</h3></td>
		<td align="right">1개(1/1 페이지)</td>
	</tr>
</table>

<table style="border-collapse: collapse;">
	<tr align="center" bgcolor="#006461;">
		<th width="60">번호</th>
		<th>제목</th>
		<th width="100">첨부</th>
		<th width="80">기안일</th>
		<th width="60">결재상태</th>
	</tr>

	<tr align="center" style="border-bottom: 1px solid #cccccc;">
		<td>1</td>
		<td align="left" style="padding-left: 10px;"><a href="#">휴가신청서</a>
		</td>
		<td>파일이미지</td>
		<td>2010-10-10</td>
		<td>미결</td>
	</tr>
</table>