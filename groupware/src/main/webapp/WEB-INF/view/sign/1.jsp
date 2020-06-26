<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();

	Date nowDate = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
%>
<style>
* {
	padding: 0px;
	margin: 0px;
	font-size: 13px;
}

input {
	border: 1px solid gray;
	height: 30px;
	padding-left: 10px;
	border-radius: 5px;
}

textarea {
	border: 1px solid gray;
	width: 900px;
	height: 500px;
	padding-left: 10px;
	border-radius: 5px;
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
	<input type="hidden" class="hiddenSnum" value="${sNum}">
	<table class="body" style="text-align: center;">
		<tr class="headLineTr">
			<td class="headLineTd" colspan="4">
			<div class="returnMemoDiv" style=" position: absolute ; display: none;">
					<textarea  class="returnTxADiv" rows="5" cols="10" placeholder="반려사유를 작성해주세요" style="width: 350px; height: 100px; resize: none;
							padding-top: 5px;"></textarea>
					<br><button type="button" class="returnMemo">반려하기</button>
			</div>
			<p class="pTag">업 무 기 안</p>
			</td>
		</tr>
		<tr>
			<td class="menus"></td>
		</tr>
		<tr>
			<td>
				<div class="leftMenu">
					<table>
						<tr>
							<td style="width: 30%; background: #BDBDBD"><b>기안자</b></td>
							<td>${sessionScope.employee.name}</td>
						</tr>
						<tr>
							<td style="background: #BDBDBD"><b>소속</b></td>
							<td>${sessionScope.employee.dType}</td>
						</tr>
						<tr>
							<td style="background: #BDBDBD"><b>기안일</b></td>
							<c:if test="${mode=='article'}">
								<td class="sdayTd">
									${dto.sdate}</td>
							</c:if>
							<c:if test="${mode!='article'}">
								<td><%=sf.format(nowDate)%></td>
							</c:if>
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
							<td rowspan="3"
								style="background: #BDBDBD; width: 70px; text-align: left;"><b>결재</b></td>
							<td class="typeTd" style="height: 17px; width: 1000px;">${ mode=="article" ? pempNo4.dType : " " }&nbsp;
								${ mode=="article" ? pempNo4.pType : " " }</td>
						</tr>
						<tr>
							<td class="nameTd" style="width: 210px; height: 80px;">${ mode=="article" ? pempNo4.name : " " }
							</td>
						</tr>
						<tr>
							<td style="height: 20px;"><c:if test="${empty mode}">
									<button type="button" id="btnLine" style="font-weight: bold">+${mode}</button>
								</c:if> <c:if test="${not empty mode}">
									<p id="btnLine">
										<c:if test="${dto.scurrStep == 3}">
											<c:if test="${pempNo4.empNo == sessionScope.employee.empNo}">
												<button type="button" class="choiceBtn"
													style="font-weight: bold" value="ok">승인</button>
												<button type="button" class="choiceBtn"
													style="font-weight: bold" value="no">반려</button>
											</c:if>
										</c:if>
										<c:if test="${dto.scurrStep > 3 }">
										<p>결재완료</p>
										</c:if>
									</p>
								</c:if> <input type="hidden" name="lineEmp4" id="lineEmp4" value="0">
							</td>
						</tr>
					</table>
				</div>
				<div class="rightMenu" id="lineDiv3">
					<input type="hidden" value="3" name="lineDivChild">
					<table style="width: 150px;">
						<tr>
							<td rowspan="3"
								style="background: #BDBDBD; width: 70px; text-align: left;"><b>결재</b></td>
							<td class="typeTd" style="height: 17px; width: 1000px;">${ mode=="article" ? pempNo3.dType : " " }&nbsp;
								${ mode=="article" ? pempNo3.pType : " " }</td>
						</tr>
						<tr>
							<td class="nameTd" style="width: 210px; height: 80px;">${ mode=="article" ? pempNo3.name : " " }
							</td>
							
						</tr>
						<tr>
							<td style="height: 20px;"><c:if test="${empty mode}">
									<button type="button" id="btnLine" style="font-weight: bold">+${mode}</button>
								</c:if> <c:if test="${not empty mode}">
									<p id="btnLine">
										<c:if test="${dto.scurrStep == 2}">
											<c:if test="${pempNo3.empNo == sessionScope.employee.empNo}">
												<button type="button" class="choiceBtn"
													style="font-weight: bold" value="ok">승인</button>
												<button type="button" class="choiceBtn"
													style="font-weight: bold" value="no">반려</button>
											</c:if>
										</c:if>
										<c:if test="${dto.scurrStep > 2 }">
										<p>결재완료</p>
										</c:if>
									</p>
								</c:if> <input type="hidden" name="lineEmp3" id="lineEmp3" value="0">
							</td>
						</tr>
					</table>
				</div>
				<div class="rightMenu" id="lineDiv2">
					<input type="hidden" value="2" name="lineDivChild">
					<table style="width: 150px;">
						<tr>
							<td rowspan="3"
								style="background: #BDBDBD; width: 70px; text-align: left;"><b>결재</b></td>
							<td class="typeTd" style="height: 17px; width: 1000px;">
							${ mode=="article" ? pempNo2.dType : " " }&nbsp;
								${ mode=="article" ? pempNo2.pType : " " }</td>
						</tr>
						<tr>
							<td class="nameTd" style="width: 210px; height: 80px;">${ mode=="article" ? pempNo2.name : " " }
							</td>
						</tr>
						<tr>
							<td style="height: 20px;"><c:if test="${empty mode}">
									<button type="button" id="btnLine" style="font-weight: bold">+${mode}</button>
								</c:if> <c:if test="${not empty mode}">
									<p id="btnLine">
										<c:if test="${dto.scurrStep == 1}">
											<c:if test="${pempNo2.empNo == sessionScope.employee.empNo}">
												<button type="button" class="choiceBtn"
													style="font-weight: bold" value="ok">승인</button>
												<button type="button" class="choiceBtn"
													style="font-weight: bold" value="no">반려</button>
											</c:if>
										</c:if>
										<c:if test="${dto.scurrStep > 1 }">
										<p>결재완료</p>
										</c:if>
									</p>
								</c:if> <input type="hidden" name="lineEmp2" id="lineEmp2" value="0">
							</td>
						</tr>
					</table>
				</div>
		<div class="rightMenu" id="lineDiv1">
			<input type="hidden" value="1" name="lineDivChild">
			<table style="width: 150px;">
				<tr>
					<td rowspan="3"
						style="background: #BDBDBD; width: 70px; text-align: left;"><b>결재</b></td>
					<td class="typeTd" style="height: 17px; width: 1000px;">${ mode=="article" ? writer.dType : sessionScope.employee.dType }
						&nbsp; ${ mode=="article" ? writer.pType : sessionScope.employee.pType }
					</td>
				</tr>
				<tr>
					<td class="nameTd" style="width: 210px; height: 80px;">${ mode=="article" ? writer.name : sessionScope.employee.name}
					</td>
				</tr>
				<tr>
					<td height="20px;">
						<p>확인</p> <input type="hidden" name="lineEmp1" value="0">
					</td>
				</tr>
			</table>
		</div>

	</table>
	<div class="contentDiv">
		<table class="content">
			<tr>
				<td style="width: 150px; background: #BDBDBD"><b>시행일자</b></td>
				<c:if test="${mode == 'article'}">
					<td style="width: 50%;">
						<input type="text" id="startDay" name="startDay" value="${dto.startDay}" disabled="disabled" style="border: none;">
					</td>
				</c:if>
				<c:if test="${mode != 'article'}">
					<td style="width: 50%;"><input type="text" id="startDay" name="startDay"></td>
				</c:if>
				<td style="background: #BDBDBD" width="100px;"><b>시행 부서</b></td>
				<td>
					<input type="text" id="sDept" value="${mode == 'acticle' ? dto.sdept : sessionScope.employee.dType }"
					 disabled="disabled" style="border: none;">
				</td>
			</tr>
			<tr>
				<td style="background: #BDBDBD"><b>제목</b></td>
				<td colspan="3">
				<c:if test="${mode == 'article'}">
					<input type="text" id="sSubject" name="ssubject" value="${mode == 'article' ? dto.ssubject : ''}" disabled="disabled"
						style="border: none;">
				</c:if>
				<c:if test="${mode != 'article'}">
					<input type="text" id="sSubject" name="ssubject" value="${mode == 'article' ? dto.ssubject : ''}">
				</c:if>
				</td>
			</tr>
			<tr>
				<td style="background: #BDBDBD" colspan="4"><b>내용</b></td>
			</tr>
			<tr>
				<td colspan="4" style="padding-left: 40px;">
				<c:if test="${mode == 'article'}">
					<textarea rows="12"cols="50" style="border:none; width: 900px; height: 420px; resize: none;" id="sContent" name="scontent" disabled="disabled">${dto.scontent}</textarea>
				</c:if>
				<c:if test="${mode != 'article'}">
					<textarea rows="12"cols="50" style="width: 900px; height: 420px; resize: none;" id="sContent" name="scontent"></textarea>
				</c:if>
				</td>
			</tr>
		</table>
	</div>
	<c:if test="${mode != 'article' }">
		<button type="button" style="margin-left: 20px;" onclick="check();">등록하기</button>
	</c:if>
</form>



<!-- 크리에이트 모달 -->
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


