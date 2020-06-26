<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<table style="margin: 10px auto 0px; width: 100%; border-spacing: 0px;">
		  <tr height="40"> 
		      <td width="100"style="font-weight:600; padding-right:15px; text-align: right;">제&nbsp;&nbsp;목</td>
		      <td> 
                     <span id="schedulerTitle"></span>
              </td>
		  </tr>

		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">작성자</td>
		      <td> 
		             <span id="schedulerName"></span>
		      </td>
		  </tr>
		
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">일정분류</td>
		      <td> 
		        	<span id="schedulerCategory"></span>
		      </td>
		  </tr>
		  
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">종일일정</td>
		      <td> 
		        	<span id="schedulerAllDay"></span>
		      </td>
		  </tr>

		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">시작일자</td>
		      <td> 
		        	<span id="schedulerStartDate"></span>
		      </td>
		  </tr>
		  
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">종료일자</td>
		      <td> 
		        	<span id="schedulerEndDate"></span>
		      </td>
		  </tr>
		
		  <tr> 
		      <td width="100" style="font-weight:600; padding-right:15px; padding-top:5px; text-align: right;" valign="top">내&nbsp;&nbsp;용</td>
		      <td> 
		           <div id="schedulerContent" style="height: 60px; line-height:100%; white-space: pre; padding-top: 10px; overflow: auto;"></div>
		      </td>
		  </tr>
</table>
