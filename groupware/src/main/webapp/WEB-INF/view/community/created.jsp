<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

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
		var url="<%=cp%>/community/deleteFile";
		$.post(url, {fileNum:fileNum}, function(data){
			$("#f"+fileNum).remove();
		}, "json");
  }
</c:if>
</script>

<script type="text/javascript">
    function sendOk() {
        var f = document.communityForm;

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

    	f.action="<%=cp%>/community/${mode}";

        f.submit();
    }
 
</script>

<div class="container">
    <div class="board-container">
        <div class="body-title">
            <h3>♬ 커뮤니티 </h3>
        </div>
        
        <div class="board-created">
			<form name="communityForm" method="post" enctype="multipart/form-data">
			  <table class="boardtable" style="margin: 20px auto 0px; ">
			  <tbody id="tb">
				  <tr align="left" height="40"> 
				      <td width="100"  style="text-align: center;">작 성 자</td>
				      <td style="padding-left:10px;"> 
				          <input class="inputnoline" type="text" name="writer" maxlength="100" value="${dto.writer}">
				      </td>
				  </tr>
				  
				  <tr align="left" height="50" > 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</td>
				      <td style="padding-left:10px;"> 
				        <input class="inputnoline" type="text" name="title" maxlength="100"value="${dto.title}">
				      </td>
				  </tr>		  
				  
				   <tr align="left" height="50" > 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center;">동호회 분류</td>
				      <td style="padding-left:10px;"> 
			      		<select name="clubCode">
			     			<option value="BW" ${clubCode=="BW"?"selected='selected'":""}>볼링</option>
			     			<option value="GF" ${clubCode=="GF"?"selected='selected'":""}>골프</option>
			     			<option value="EC" ${clubCode=="EC"?"selected='selected'":""}>영어회화</option>
			     			<option value="BG" ${clubCode=="BG"?"selected='selected'":""}>보드게임</option>			     				     	
			     		</select>			   
			      	</td>
				  </tr>
			
				  <tr align="left"> 
				      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="middle">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</td>
				      <td valign="top" style="padding:5px 0px 5px 10px;"> 
				        <textarea name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
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
			        <button type="button" class="boardBtn" onclick="javascript:location.href='<%=cp%>/community/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			      	 <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="commuNum" value="${dto.commuNum}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			      </td>
			    </tr>
			  </table>
			</form>
        </div>

    </div>
</div>

