<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

</script>
<script type="text/javascript">
    function check() {
        var f = document.newsForm;

    	var str = f.title.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.title.focus();
            return false;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return false;
        }
        
        str = f.nCode.value;
        if(!str) {
            alert("분류를 선택하세요.");
            f.nCode.focus();
            return false;
        }

   		f.action="<%=cp%>/news/${mode}";

        return true;
    }
 
</script>

<div class="container">
    <div class="board-container">
        <div class="board-title">
            <h3>소식 </h3>
        </div>
        
        <div class="board-created">
			<form name="newsForm" method="post" onsubmit="return submitContents(this);">
			  <table class="boardtable">
				  <tr align="left" height="40"> 
				      <td width="100"  style="text-align: center;">작 성 자</td>
				      <td style="padding-left:10px;"> 
				        	 ${sessionScope.employee.name }
				      </td>
				  </tr>
				  
				   <tr align="left" height="40"> 
				      <td width="100"  style="text-align: center;">분&nbsp; &nbsp;&nbsp;&nbsp;류</td>
				      <td style="padding-left:10px;"> 
						  <select name="nCode"  class="selectField">
						  	  <option value="">::선 택::</option>
						      <option value="COMPANY" ${dto.nCode=="COMPANY"?"selected='selected'":""}>회사소식</option>
						      <option value="MR" ${dto.nCode=="MR"?"selected='selected'":""}>결혼</option>
						      <option value="FU" ${dto.nCode=="FU"?"selected='selected'":""}>부고</option>
						      <option value="BI" ${dto.nCode=="BI"?"selected='selected'":""}>츨산</option>
						      <option value="PR" ${dto.nCode=="PR"?"selected='selected'":""}>승진</option>
						      <option value="ETC" ${dto.nCode=="ETC"?"selected='selected'":""}>기타</option>
					      </select> 
				 
				      </td>
				  </tr>
				  
				  <tr align="left" height="50" > 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				      <td style="padding-left:10px;"> 
				        <input class="inputnoline" type="text" name="title" maxlength="100"value="${dto.title}">
				      </td>
				  </tr>		  
			
				  <tr align="left"> 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="middle">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				      <td valign="top" style="padding:5px 0px 5px 10px;"> 
				        <textarea name="content" id="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}${page }</textarea>
				      </td>
				  </tr>         
			  </table>
			
			  <table>
			     <tr height="45"> 
			      <td align="center" >
			        <button type="submit" class="boardBtn">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="boardBtn">다시입력</button>
			        <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/news/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			        <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="newsNum" value="${dto.newsNum}">
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

