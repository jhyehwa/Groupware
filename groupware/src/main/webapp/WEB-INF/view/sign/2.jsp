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

.pTag{
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
	width: 40%;
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
	height: 45px;
}

.content tr td {
	padding-left: 10px;
	border-left: 1px solid black;
	padding-top: 5px;
	padding-bottom: 5px;
}

.contentDiv {
	padding: 3px;
	height: 50%;
}
</style>
<table class="body">
	<tr class="headLineTr">
		<td class="headLineTd" colspan="4"><p class="pTag">휴가신청서</p></td>
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
				<div class="rightMenu">
					<table>
						<tr>
							<td rowspan="3" style="background: #BDBDBD"><b>신청</b></td>
							<td>기안자직급</td>
						</tr>
						<tr>
							<td style="height: 85px;">기안자명</td>
						</tr>
						<tr>
							<td>사인결재란</td>
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
			<td style="width: 100px; background: #BDBDBD"><b>휴가종류</b></td>
			<td>
			<select>
					<option>1. 연차</option>
					<option>2. 월차</option>
					<option>3. 반차</option>
					<option>4. 조퇴</option>
			</select></td>
		</tr>
		<tr>
			<td style="background: #BDBDBD"><b>기간 및 일시</b></td>
			<td>달력그림 클릭 후 기간 설정(범위지정)</td>
		</tr>
		<tr>
			<td style="background: #BDBDBD"><b>연차 일수</b></td>
			<td>잔여연차 : 로그인 사용자의 잔여연차, 신청연차 : 신청한 연차(반차 시 0.5)</td>
		</tr>
		<tr style="height: 400px;">
			<td style="background: #BDBDBD"><b>사유</b></td>
			<td>사유</td>
		</tr>
		<tr>
			<td colspan="2" style="background: #BDBDBD">
			<h6>1. 연차의 사용은 근로기준법에 따라 전년도에 발생한 개인별 잔여 연차에 한하여 사용함을 원칙으로 한다. 단, 최초 입사시에는 근로 기준법에 따라 발생 예정된
				연차를 차용하여 월 1회 사용 할 수 있다.</h6>
			<h6>2. 경조사 휴가는 행사일을 증명할 수 있는 가족 관계 증명서 또는 등본, 청첩장 등 제출</h6>
			<h6>3. 공가(예비군/민방위)는 사전에 통지서를, 사후에 참석증을 반드시 제출</h6>
			</td>
		</tr>
	</table>
</div>

