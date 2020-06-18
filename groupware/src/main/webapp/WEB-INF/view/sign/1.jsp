<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
* {
	padding: 0px;
	margin: 0px;
}

.body {
	width: 100%;
	margin-bottom: 10px;
}

.headLineTr {
	height: 100px;
	text-align: center;
}

.headLineTd {
	text-align: center;
}

.pTag {
	font-size: 40px;
	font-family: "맑은고딕";
	font-weight: 900;
	padding: 60px;
}

.bodyDiv {
	border-collapse: collapse;
	border: none;
}

.leftMenu {
	float: left;
	width: 30%;
}

.leftMenu table {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid black;
}

.leftMenu tr {
	border: 1px solid black;
}

.leftMenu tr td {
	height: 35px;
	padding-left: 10px;
	border-left: 1px solid black;
}

.rightMenu {
	float: right;
	width: 15%;
	height: 140px;
}

.rightMenu table {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid black;
}

.rightMenu tr {
	border: 1px solid black;
}

.rightMenu tr td {
	padding-left: 10px;
	border-left: 1px solid black;
	padding-top: 5px;
	padding-bottom: 5px;
}

.content {
	width: 100%;
	border-collapse: collapse;
	border: 1px solid black;
	margin-bottom: 10px;
}

.content tr {
	border: 1px solid black;
}

.content tr td {
	padding-left: 10px;
	border-left: 1px solid black;
	padding-top: 5px;
	padding-bottom: 5px;
}

.contentDiv {
	padding: 3px;
}

.lineModal {
	display: none;
	background-color: #FFFFFF;
	position: absolute;
	border: 2px solid #E2E2E2;
	z-Index: 9999
}
</style>

<form method="post" name="inputForm" id="inputForm">
	<table class="body">
		<tr class="headLineTr">
			<td class="headLineTd" colspan="4"><p class="pTag">업 무 기 안</p></td>
		</tr>
		<tr>
			<td class="menus">
		<tr>
			<td>
				<div class="bodyDiv">
					<div class="leftMenu">
						<table>
							<tr>
								<td style="width: 30%; background: #BDBDBD"><b>기안자</b></td>
								<td>기안자이름</td>
							</tr>
							<tr>
								<td style="background: #BDBDBD"><b>소속</b></td>
								<td>기안자소속</td>
							</tr>
							<tr>
								<td style="background: #BDBDBD"><b>기안일</b></td>
								<td>오늘날짜</td>
							</tr>
							<tr>
								<td style="background: #BDBDBD"><b>문서번호</b></td>
								<td>-</td>
							</tr>
						</table>
					</div>
					<div class="rightMenu" id="lineDiv4">
					<input type="hidden" value="4" name="lineDivChild">
						<table style="width: 150px;">
						<tr>
								<td rowspan="3" style="background: #BDBDBD; width: 70px;"><b>결재</b></td>
								<td class="typeTd" style="height: 17px;"></td>
							</tr>
							<tr>
								<td class="nameTd" style="width: 210px; height: 80px;"></td>
							</tr>
							<tr>
								<td>
								<button type="button" id="btnLine" style="font-weight: bold">
								+</button>
								<input type="hidden" name="lineEmp1" value="0">
								</td>
							</tr>
						</table>
					</div>
					<div class="rightMenu" id="lineDiv3">
					<input type="hidden" value="3" name="lineDivChild">
						<table style="width: 150px;">
						<tr>
								<td rowspan="3" style="background: #BDBDBD; width: 70px;"><b>결재</b></td>
								<td class="typeTd" style="height: 17px;"></td>
							</tr>
							<tr>
								<td class="nameTd" style="width: 210px; height: 80px;"></td>
							</tr>
							<tr>
								<td>
								<button type="button" id="btnLine" style="font-weight: bold">
								+</button>
								<input type="hidden" name="lineEmp1" value="0">
								</td>
							</tr>
						</table>
					</div>
					<div class="rightMenu" id="lineDiv2">
					<input type="hidden" value="2" name="lineDivChild">
						<table style="width: 150px;">
							<tr>
								<td rowspan="3" style="background: #BDBDBD; width: 70px;"><b>결재</b></td>
								<td class="typeTd" style="height: 17px;"></td>
							</tr>
							<tr>
								<td class="nameTd" style="width: 210px; height: 80px;"></td>
							</tr>
							<tr>
								<td>
								<button type="button" id="btnLine" style="font-weight: bold">
								+</button>
								<input type="hidden" name="lineEmp1" value="0">
								</td>
							</tr>
						</table>
					</div>
					<div class="rightMenu" id="lineDiv1">
						<input type="hidden" value="1" name="lineDivChild">
						<table style="width: 150px;">
							<tr>
								<td rowspan="3" style="background: #BDBDBD; width: 70px;"><b>결재</b></td>
								<td class="typeTd" style="height: 17px;">${sessionScope. }</td>
							</tr>
							<tr>
								<td class="nameTd" style="width: 210px; height: 80px;"></td>
							</tr>
							<tr>
								<td>
								<button type="button" id="btnLine" style="font-weight: bold">
								+</button>
								<input type="hidden" name="lineEmp1" value="0">
								</td>
							</tr>
						</table>
					</div>
				</div>
			</td>
		</tr>


	</table>
	<div class="contentDiv">
		<table class="content">
			<tr>
				<td style="width: 150px; background: #BDBDBD"><b>시행일자</b></td>
				<td style="width: 50%;"><input type="text" id="sDay"
					name="sDay"></td>
				<td style="background: #BDBDBD" width="100px;"><b>시행 부서</b></td>
				<td><input type="text" id="sDept"></td>
			</tr>
			<tr>
				<td style="background: #BDBDBD"><b>제목</b></td>
				<td colspan="3"><input type="text" id="sSubject"
					name="ssubject"></td>
			</tr>
			<tr>
				<td style="background: #BDBDBD" colspan="4"><b>내용</b></td>
			</tr>
			<tr style="height: 500px;">
				<td colspan="4"><textarea rows="20" cols="50"
						style="resize: none;" id="sContent" name="scontent"></textarea></td>
			</tr>
		</table>
	</div>
	<button type="button" onclick="check();">등록하기</button>
</form>


<!-- 모달 -->
<div id="lineModal-dialog" class="lineModal">


		<div class="listDiv">
			<table id="listTable" class="listTable" style="width: 580px;">
				<tr style="background: #E3F6CE; text-align: center;">
					<td style="width: 50px;">선택</td>
					<td style="width: 50px;">부서</td>
					<td style="width: 50px;">직급</td>
					<td style="width: 150px;">이름</td>
				</tr>
				<c:forEach var="dto" items="${list}">
					<tr style="text-align: center;">
						<td><input type="checkbox" name="cb" value="${dto.empNo}"></td>
						<td><input type="hidden" name="hDType" value="${dto.dType}">${dto.dType}</td>
						<td><input type="hidden" name="hPType" value="${dto.pType}">${dto.pType}</td>
						<td><input type="hidden" name="hName" value="${dto.name}">${dto.name}</td>
					</tr>
				</c:forEach>
			</table>
			<button type="button" id="btnLineSelectOk" class="close">선택</button>
		</div>

</div>
