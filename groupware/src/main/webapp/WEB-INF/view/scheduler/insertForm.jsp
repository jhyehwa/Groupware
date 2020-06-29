<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<script type="text/javascript">
$(function() {
    $("input[name=startDate]").datepicker();
    $("input[name=endDate]").datepicker();
});
</script>

<form name="schedulerForm" method="post">
<table style="margin: 10px auto 0px; width: 100%; border-spacing: 0px;">
	  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">제&nbsp;&nbsp;목</td>
		      <td> 
                     <input name='title' type='text' class='boxTF' style="width:98%;" placeholder='제목'>
              </td>
	  </tr>

	  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">작성자</td>
		      <td> 
		             ${sessionScope.employee.name}
		      </td>
	  </tr>

	  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">일정분류</td>
		      <td> 
		        	<select name='category' class='selectField'>
	                     <option value='#9565A4' ${dto.category=='#9565A4'?"selected='selected'":""}> 개인일정 </option>
	                     <option value='#EDA900' ${dto.category=='#EDA900'?"selected='selected'":""}> 회사일정 </option>
	                     <option value='red' ${dto.category=='red'?"selected='selected'":""}> 부서일정 </option>
                    </select>
		      </td>
	  </tr>
		  
	  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">종일일정</td>
		      <td> 
		        	하루종일&nbsp;&nbsp;<input type="checkbox" id="allDayChk"  name="allDay" value="true">
		        	                               <input type="hidden" id="allDayHidden"  name="allDay" value="false">
		      </td>
	  </tr>

	  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">시작일자</td>
		      <td> 
		        	<input name="startDate" type="text" readonly="readonly" class="boxTF" style="background: #fff; width: 120px;" placeholder="시작날짜">
		        	<input id="startTime" name="startTime" type="text" class="boxTF" style="width: 120px;" placeholder="시작시간">
		      </td>
	  </tr>
		  
	  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">종료일자</td>
		      <td> 
		        	<input name="endDate" type="text" readonly="readonly" class="boxTF" style="background: #fff; width: 120px;" placeholder="종료날짜">
		        	<input id="endTime" name="endTime" type="text" class="boxTF" style="width: 120px;" placeholder="종료시간">
		      </td>
	  </tr>
		
	  <tr> 
		      <td width="100" style="font-weight:600; padding-right:15px; padding-top:5px; text-align: right;" valign="top">내&nbsp;&nbsp;용</td>
		      <td valign="top" style="padding:5px 0px 5px 0px;"> 
		           <textarea name="content" cols="50" rows="3" class="boxTA" style="width:97%; height: 60px;"></textarea>
		           <input type="hidden" name="schNum" value="0">
		      </td>
	  </tr>
</table>
</form>