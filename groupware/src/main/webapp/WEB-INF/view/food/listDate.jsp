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
			  <tr  height="20">
			  		<td  style="padding: 10px 0 10px 50px; background:SEASHELL; border-radius:20px; font-size: 20px">
						<span >${dto.subject=='LUNCH'? '점심' : (dto.subject=='DINNER'? '저녁': '간식')}
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</span>
						<span>
						<c:if test="${sessionScope.employee.empNo=='10001'}">			      
				        	<button type="button" class="btn" id="btnFoodDelete"  onclick="deleteOk('${dto.foodNum}');"><i class="fas fa-times"></i></button>
			        	</c:if>
			        	</span>
					</td>
			  </tr>	

			  <tr height="45">
			      <td style="padding: 15px 0 15px 50px;">
			        <p style="margin-top: 2px; margin-bottom: 30px;">${dto.content}</p>
			      </td>
			  </tr>
			  
			 </c:forEach> 

			</table>
		</form>
    </div>

