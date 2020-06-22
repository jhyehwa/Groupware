<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
	

	Date nowDate = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
%>
<style>
* {
	padding: 0px;
	margin: 0px;
	font-size: 13px;
}

input{
	border: 1px solid gray;
	height: 30px;
	padding-left:10px;
	border-radius: 5px;
}

textarea{
	border: 1px solid gray;
	width: 900px;
	height: 500px;
	padding-left:10px;
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
	<table class="body">
		<tr class="headLineTr">
			<td class="headLineTd" colspan="4"><p class="pTag">업 무 기 안</p></td>
		</tr>
		<tr>
			<td class="menus"></td>
		</tr>
		<tr>
			<td>
				<div class="bodyDiv">
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
								<td class="sdayTd">
								<c:if test="${mode=='article'}">
									${dto.startDay}
								</c:if>
								<%=sf.format(nowDate)%>
								</td>
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
								<td class="typeTd" style="height: 17px;">
									${ mode=="article" ? pempNo4.dType : " " }
									 / 
									${ mode=="article" ? pempNo4.pType : " " }
								</td>
							</tr>
							<tr>
								<td class="nameTd" style="width: 210px; height: 80px;">
									${ mode=="article" ? pempNo4.name : " " }
								</td>
							</tr>
							<tr>
								<td height="20px;">
								<button type="button" id="btnLine" style="font-weight: bold">
								+</button>
								<input type="hidden" name="lineEmp4" id="lineEmp4" value="0">
								</td>
							</tr>
						</table>
					</div>
					<div class="rightMenu" id="lineDiv3">
					<input type="hidden" value="3" name="lineDivChild">
						<table style="width: 150px;">
						<tr>
								<td rowspan="3" style="background: #BDBDBD; width: 70px;"><b>결재</b></td>
								<td class="typeTd" style="height: 17px;">
									${ mode=="article" ? pempNo3.dType : " " }
									 / 
									${ mode=="article" ? pempNo3.pType : " " }
								</td>
							</tr>
							<tr>
								<td class="nameTd" style="width: 210px; height: 80px;">
								${ mode=="article" ? pempNo3.name : " " }
								</td>
							</tr>
							<tr>
								<td height="20px;">
								<button type="button" id="btnLine" style="font-weight: bold">
								+</button>
								<input type="hidden" name="lineEmp3" id="lineEmp3" value="0">
								</td>
							</tr>
						</table>
					</div>
					<div class="rightMenu" id="lineDiv2">
					<input type="hidden" value="2" name="lineDivChild">
						<table style="width: 150px;">
							<tr>
								<td rowspan="3" style="background: #BDBDBD; width: 70px;"><b>결재</b></td>
								<td class="typeTd" style="height: 17px;">
									${ mode=="article" ? pempNo2.dType : " " }
									 / 
									${ mode=="article" ? pempNo2.pType : " " }
								</td>
							</tr>
							<tr>
								<td class="nameTd" style="width: 210px; height: 80px;">
									${ mode=="article" ? pempNo2.name : " " }
								</td>
							</tr>
							<tr>
								<td>
								<button type="button" id="btnLine" style="font-weight: bold">
								+</button>
								<input type="hidden" name="lineEmp2" id="lineEmp2" value="0">
								</td>
							</tr>
						</table>
					</div>
					<div class="rightMenu" id="lineDiv1">
						<input type="hidden" value="1" name="lineDivChild">
						<table style="width: 150px;">
							<tr>
								<td rowspan="3" style="background: #BDBDBD; width: 70px;"><b>결재</b></td>
								<td class="typeTd" style="height: 17px;">
								${ mode=="article" ? writer.dType : sessionScope.employee.dType }
								 / 
								${ mode=="article" ? writer.pType : sessionScope.employee.pType }
								</td>
							</tr>
							<tr>
								<td class="nameTd" style="width: 210px; height: 80px;">
								${ mode=="article" ? writer.name : sessionScope.employee.name}
								</td>
							</tr>
							<tr>
								<td height="20px;">
								<p>확인</p>
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
				<td style="width: 50%;">
					<input type="text" id="startDay" name="startDay" value="${dto.startDay}"></td>
				<td style="background: #BDBDBD" width="100px;"><b>시행 부서</b></td>
				<td>
				<input type="text" id="sDept" value="${mode == 'acticle' ? dto.sdept : sessionScope.employee.dType }" readonly="readonly">
				
				</td>
			</tr>
			<tr>
				<td style="background: #BDBDBD"><b>제목</b></td>
				<td colspan="3">
				<input type="text" id="sSubject" name="ssubject" value="${dto.ssubject}"></td>
			</tr>
			<tr>
				<td style="background: #BDBDBD" colspan="4"><b>내용</b></td>
			</tr>
			<tr>
				<td colspan="4" style="padding-left: 40px;">
				<textarea rows="12" cols="50" style="width:900px; height:420px; resize: none;" id="sContent" name="scontent">
				${dto.scontent}
				</textarea>
				</td>
			</tr>
		</table>
	</div>
	<button type="button" style="margin-left: 20px;" onclick="check();">등록하기</button>
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


<script type="text/javascript">

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "sContent",
	sSkinURI: "<%=cp%>/resource/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			// alert("아싸!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["sContent"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["sContent"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["sContent"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["sContent"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>
