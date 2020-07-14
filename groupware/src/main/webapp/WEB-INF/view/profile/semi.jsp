<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<form name="employeeForm" method="post">
			<div id="div-one">
				<div id="div-one-right" style="margin-top: 55px;">
					<img src="<%=cp%>/uploads/profile/${dto.imageFilename}" width="150" height="150" border="0"> 
					<div style="padding-left: 0px;">
						<label id="icon" style="margin-left: 0px;"><i class="fas fa-pen"></i></label>
							<input type="text" name="intro" value="${dto.intro}" placeholder="&nbsp;자신을 표현 해 보세요!" readonly="readonly" />
					</div>					
				</div>
				
	
				<div id="div-two" style="margin-top: 40px;">
					<div>
						<label id="icon"><i class="fas fa-user"></i></label>
							<input type="text" name="empNo" id="empNo" value="${dto.empNo}" readonly="readonly" />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-signature"></i></label>
						<input type="text" name="name" value="${dto.name}" readonly="readonly" />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-users"></i></label>
						<input type="text" name="addr" value="${dto.dType} | ${dto.pType}" readonly="readonly" />
					</div>				
					
					<div>
					<label id="icon"><i class="fas fa-birthday-cake"></i></label>
						<input type="text" name="birth" value="${dto.birth}" readonly="readonly" />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-mobile-alt"></i></label>
						<input type="text" name="tel" value="${dto.tel}" readonly="readonly" />
					</div>
					
					<div>
					<label id="icon"><i class="far fa-envelope-open"></i></label>
						<input type="text" name="email" value="${dto.email}" readonly="readonly" />
					</div>
				
					<div>
						<label id="icon"><i class="fas fa-sign-in-alt"></i></label>
							<input type="text" name="enterDate" value="${dto.enterDate}" readonly="readonly" />
					</div>				
					
					
				</div>
			</div>
			
		</form>