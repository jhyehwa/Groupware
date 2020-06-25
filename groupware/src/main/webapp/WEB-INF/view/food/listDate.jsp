<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">

 <div id="food-detail" >
		<form name="foodDetail-Form">
			<table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
			<c:forEach var="dto" items="${list}">
			  <tr>
			  		<td  style="padding: 30px 0 0 30px">
						<p><button type="button" disabled="disabled" id="menuBtn">${dto.subject=='LUNCH'? '점심메뉴' : (dto.subject=='DINNER'? '저녁메뉴': '간식')}</button><p>
					</td>
			  </tr>	

			  <tr height="45">
			      <td style="padding: 15px 0 15px 50px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">${dto.content}</p>
			      </td>
			  </tr>
			  
			  <tr height="45">
			      <td align="center" style="border-bottom: 1px solid #632A7E;">			      
			      	<c:if test="${sessionScope.employee.empNo==dto.writer}">			      
				        <button type="button" class="btn" id="btnFoodDelete"  onclick="deleteOk('${dto.foodNum}');">삭제</button>
			        </c:if>
			      </td>
			  </tr>
			 </c:forEach> 

			</table>
		</form>
    </div>

