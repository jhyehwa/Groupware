<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/normalize.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<style type="text/css">
.testbox {
	margin: 0px auto;
	width: 800px;
	height: 550px;
	/* background: gray; */
}

h1 {
	font-size: 32px;
	font-weight: 300;
	color: #4c4c4c;
	text-align: center;
	padding-top: 10px;
	margin-bottom: 10px;
}

form {
	margin: 0 30px;
}

#icon {
	display: inline-block;
	width: 30px;
	background-color: #412065;
	padding: 8px 0px 8px 15px;
	margin-left: 15px;
	-webkit-border-radius: 4px 0px 0px 4px;
	-moz-border-radius: 4px 0px 0px 4px;
	border-radius: 4px 0px 0px 4px;
	color: white;
	-webkit-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	-moz-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	border: solid 0px #cbc9c9;
}

input[type=text], input[type=password], .selectBox {
	width: 200px;
	height: 39px;
	-webkit-border-radius: 0px 4px 4px 0px/5px 5px 4px 4px;
	-moz-border-radius: 0px 4px 4px 0px/0px 0px 4px 4px;
	border-radius: 0px 4px 4px 0px/5px 5px 4px 4px;
	background-color: #fff;
	-webkit-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	-moz-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	border: solid 1px #cbc9c9;
	margin-left: -5px;
	margin-top: 13px;
	padding-left: 10px;
}

input:focus {
	outline: none;
}

.selectGroup {
	height: 39px;
	position: relative;
	/* background: orange; */
}

.selectGroup .selectBox {
	/* background: silver; */
	width: 205px;
	height: 39px;
	position: absolute;
	top: 0;
	z-index: 1;
	border: none;
	background: transparent;
	-webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
	cursor: pointer;
	padding: 5px 15px;
	margin-left: 3px;
	font-size: 15px;
}

.selectGroup:before {
	content: '';
	position: absolute;
	width: 210px;
	height: 39px;
	z-index: 0;
	margin-left: 58px;
	margin-top: -5px;
	-webkit-border-radius: 0px 4px 4px 0px/5px 5px 4px 4px;
	-moz-border-radius: 0px 4px 4px 0px/0px 0px 4px 4px;
	border-radius: 0px 4px 4px 0px/5px 5px 4px 4px;
	background-color: #fff;
	-webkit-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	-moz-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	border: solid 1px #cbc9c9;
}

.selectGroup:after {
	content: '';
	position: absolute;
	right: 30px;
	width: 30px;
	height: 39px;
	background-color: #fff400;
	background-image: url(https://raw.githubusercontent.com/solodev/styling-select-boxes/master/select1.png);
	background-position: center;
	background-repeat: no-repeat;
	z-index: 0;
	margin-top: -5px;
	-webkit-border-radius: 0px 4px 4px 0px/5px 5px 4px 4px;
	-moz-border-radius: 0px 4px 4px 0px/0px 0px 4px 4px;
	border-radius: 0px 4px 4px 0px/5px 5px 4px 4px;
	-webkit-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	-moz-box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	box-shadow: 1px 2px 5px rgba(0, 0, 0, .09);
	border: solid 1px #cbc9c9;
}

.button {
	font-size: 14px;
	font-weight: 600;
	color: white;
	margin:  10px 325px;
	display: inline-block;
	text-decoration: none;
	width: 100px;
	height: 30px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	background-color: #412065;
	-webkit-box-shadow: 0 3px rgba(58, 87, 175, .75);
	-moz-box-shadow: 0 3px rgba(58, 87, 175, .75);
	box-shadow: 0 3px rgba(58, 87, 175, .75);
	position: relative;
}

.button:hover {
	top: 3px;
	background-color: #2e458b;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
}
</style>
</head>
<body>
<div class="container">
	<div class="testbox">
		<h1>Register</h1>

		<form>
			<div style="/* background: purple; */ width: 740px; height: 460px;">
				<div style="margin-left: 70px; float: left; width: 300px; height: 400px; /* background: fuchsia; */border-right: 1px solid black;">
					<div>
						<label id="icon"><i class="fas fa-user"></i></label>
							<input type="text" name="empNo" placeholder="사원번호" required />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-lock"></i></label>
						<input type="password" name="pwd" placeholder="비밀번호" required />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-signature"></i></label>
						<input type="text" name="name" placeholder="성명" required />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-birthday-cake"></i></label>
						<input type="text" name="birth" placeholder="생년월일" required />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-mobile-alt"></i></label>
						<input type="text" name="tel" placeholder="전화번호" required />
					</div>
					
					<div>
					<label id="icon"><i class="far fa-envelope-open"></i></label>
						<input type="text" name="email" placeholder="이메일" required />
					</div>
					
					<div>
					<label id="icon"><i class="fas fa-home"></i></label>
						<input type="text" name="addr" placeholder="주소" required />
					</div>
				</div>
				
	
				<div style="/* background: lime; */ width: 300px; height: 400px; float: left;">
					<div class="selectGroup" style="padding-top: 15px;">
						<label id="icon"><i class="far fa-hand-rock"></i></label>
						<select class="selectBox">
							<option selected="selected">기본</option>
							<option>팀장</option>
							<option>관리자</option>
						</select>
					</div>
					<div class="selectGroup" style="padding-top: 15px;">
						<label id="icon"><i class="fas fa-users"></i></label>
						<select class="selectBox">
							<option selected="selected">::: 부서 :::</option>
							<option>개발부</option>
							<option>기획부</option>
							<option>인사부</option>
							<option>홍보부</option>
							<option>임원진</option>
							<option>경영지원부</option>
						</select>
					</div>
					
					<div class="selectGroup" style="padding-top: 15px;">
						<label id="icon"><i class="fas fa-layer-group"></i></label>
						<select class="selectBox">
							<option selected="selected">::: 직위 :::</option>
							<option>사원</option>
							<option>대리</option>
							<option>과장</option>
							<option>부장</option>
							<option>이사</option>
							<option>부사장</option>
							<option>사장</option>
						</select>
					</div>
					
					<div>
						<label id="icon"><i class="fas fa-sign-in-alt"></i></label>
							<input type="text" name="enterDate" placeholder="입사일자" required />
					</div>
					
					<div>
						<label id="icon"><i class="fas fa-sign-out-alt"></i></label>
							<input type="text" name="exitDate" placeholder="퇴사일자" required />
					</div>
					
					<div>
						<label id="icon"><i class="fas fa-sync"></i></label>
							<input type="text" name="apDate" placeholder="발령일자" required />
					</div>
					
					<div>
						<label id="icon"><i class="far fa-sticky-note"></i></label>
							<input type="text" name="memo" placeholder="메모" />
					</div>
				</div>
	
				<div>
					<button type="button" class="button">Register</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>