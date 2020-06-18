<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//clone을 사용하는 경우
$(function(){
	$("form input[name=upload]").change(function(){
		if(! $(this).val()) return;
		
		var b=false;
		$("form input[name=upload]").each(function(){
			if(! $(this).val()) {
				b=true;
				return;
			}
		});
		if(b) return false;
			
		var $tr = $(this).closest("tr").clone(true); // 이벤트도 복제
		$tr.find("input").val("");
		$("#tb").append($tr);
	});
});

  <c:if test="${mode=='update'}">
  function deleteFile(fileNum) {
		var url="<%=cp%>/data/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
  }
</c:if>
</script>

<script type="text/javascript">
    function sendOk() {
        var f = document.dataForm;

    	var str = f.title.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.title.focus();
            return;
        }

     	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        } 

    	f.action="<%=cp%>/data/${mode}";

        f.submit();
    }
 
</script>

<div class="container">
    <div class="board-container">
        <div class="body-title">
            <h3>♬ 자료실 </h3>
        </div>
        
        <div class="board-created">
			<form name="dataForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			  <table class="boardtable" style="margin: 20px auto 0px; ">
			  <tbody id="tb">
				  <tr align="left" height="40"> 
				      <td width="100"  style="text-align: center;">작 성 자</td>
				      <td style="padding-left:10px;"> 
				          <input class="inputnoline" type="text" name="writer" maxlength="100" value="${sessionScope.employee.name}">
				      </td>
				  </tr>
				  
				  <tr align="left" height="50" > 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				      <td style="padding-left:10px;"> 
				        <input class="inputnoline" type="text" name="title" maxlength="100" value="${dto.title}">
				      </td>
				  </tr>		  
				  
				   <tr align="left" height="50" > 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center;">자료 분류</td>
				      <td style="padding-left:10px;"> 
			      		<select name="dataCode">
			     			<option value="docu" ${dataCode=="docu"?"selected='selected'":""}>문서</option>
			     			<option value="set" ${dataCode=="set"?"selected='selected'":""}>설치</option>
			     			<option value="img" ${dataCode=="img"?"selected='selected'":""}>이미지</option>
			     			<option value="etc" ${dataCode=="etc"?"selected='selected'":""}>기타</option>			     				     	
			     		</select>			   
			      	</td>
				  </tr>
			
				  <tr align="left"> 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="middle">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				      <td valign="top" style="padding:5px 0px 5px 10px;"> 
				        <textarea name="content" id="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
				      </td>
				  </tr>
				  
				 <tr align="left" height="50" > 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부</td>
				      <td style="padding-left:10px;"> 
				          <input type="file" name="upload" class="boxTF" size="53" style="width: 95%; height: 25px;">
				       </td>
			  	</tr>
             	 </tbody>
              
				<c:if test="${mode=='update'}">
				   <c:forEach var="vo" items="${listFile}">
						  <tr id="f${vo.fileNum}" height="40" style="border-bottom: 1px solid #cccccc;"> 
						      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
						      <td style="padding-left:10px;"> 
								<a href="javascript:deleteFile('${vo.fileNum}');"><i class="far fa-trash-alt"></i></a> 
								${vo.originalFilename}
						      </td>
						  </tr>
				   </c:forEach>
				</c:if>
			  </table>			  
			
			  <table>
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="boardBtn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="boardBtn">다시입력</button>
			        <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/data/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			      	 <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="commuNum" value="${dto.dataNum}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			      </td>
			    </tr>
			  </table>
			</form>
        </div>

    </div>
</div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "<%=cp%>/resource/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//alert("아싸!");
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
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>

