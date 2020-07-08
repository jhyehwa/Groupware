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
			<c:forEach var="dto" items="${list}">
			<table style="width: 80%; margin:0 auto 10px; border-spacing: 0px; border:1px solid ${dto.subject=='LUNCH'? 'salmon' : (dto.subject=='DINNER'? '#F7E5F3': 'SEASHELL')}; border-radius:5px; ">
			  <tr  height="20">
			  		<td  style="padding: 10px 0 10px 30px;">
			  			<span style="color: ${dto.subject=='LUNCH'? 'salmon' : (dto.subject=='DINNER'? '#F7E5F3': 'SEASHELL')};"><i class="fas fa-apple-alt"></i></span>
						<span style="font-size: 18px; font-weight: 800;">${dto.subject=='LUNCH'? '점심' : (dto.subject=='DINNER'? '저녁': '간식')}</span>
						<span>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<c:if test="${sessionScope.employee.empNo=='10001'}">			      
				        	<button type="button" class="btn" id="btnFoodDelete"  onclick="deleteOk('${dto.foodNum}');"><i class="far fa-trash-alt"></i></button>
			        	</c:if>
			        	</span>
					</td>
			  </tr>	

			  <tr height="45">
			      <td style="padding: 15px 0 15px 70px;">
			        <p style="margin-top: 2px; margin-bottom: 5px;">${dto.content}</p>
			      </td>
			  </tr>
			  
			</table>
			 </c:forEach> 

		</form>
    </div>

