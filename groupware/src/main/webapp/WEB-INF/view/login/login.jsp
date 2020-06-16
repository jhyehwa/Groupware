<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/normalize.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">

<style type="text/css">
.login-content {
	display: flex;
	justify-content: flex-start;
	align-items: center;
 	text-align: center;
	/* background: yellow; */
}

form {
	width: 20%;
	margin: 0 auto;
	margin-top: 15%;
	/* background: aqua; */
}

.login-content .userIcon {
	position: relative;
	display: grid;
	grid-template-columns: 7% 93%;
	margin: 25px 0;
	margin-left: 10%;
	padding: 5px 0;
	width: 80%;
	border-bottom: 2px solid #d9d9d9;
}

.i {
	color: #d9d9d9;
	display: flex;
	justify-content: center;
	align-items: center;
}

.i i {
	transition: 0.3s;
}

.userIcon>div {
	position: relative;
	height: 35px;
}

.userIcon>div>h5 {
	position: absolute;
	left: 10px;
	top: 10%;
	transform: translateY(-50%);
	color: #999;
	font-size: 18px;
	transition: 0.3s;
}

.userIcon:before, .userIcon:after {
	content: "";
	position: absolute;
	bottom: -2px;
	width: 0%;
	height: 20px;
	background-color: coral;
	transition: 0.4s;
}

.userIcon:before {
	right: 50%;
}

.userIcon:after {
	left: 50%;
}

.userIcon.focus:before, .userIcon.focus:after {
	width: 50%;
}

.userIcon.focus>div>h5 {
	top: -5px;
	font-size: 15px;
}

.userIcon.focus>.i>i {
	color: coral;
}

.userIcon>div>input {
	position: absolute;
	left: 0;
	top: 0;
	width: 80%;
	height: 100%;
	border: none;
	outline: none;
	background: none;
	padding: 0.5rem 0.7rem;
	font-size: 1.2rem;
	color: #555;
	font-family: "poppins", sans-serif;
}

.userIcon.lock {
	margin-bottom: 4px;
}

.btn {
	display: block;
	width: 80%;
	height: 50px;
	border-radius: 25px;
	outline: none;
	border: none;
	background-image: linear-gradient(to right, #e88747, coral, #e88747);
	background-size: 200%;
	font-size: 1.2rem;
	color: #fff;
	font-family: "Poppins", sans-serif;
	text-transform: uppercase;
	margin: 1rem 0;
	cursor: pointer;
	transition: 0.5s;
	margin-left: 10%;
}

.btn:hover {
	background-position: right;
}
</style>

<script type="text/javascript">

</script>

</head>
<body>
	<div class="wrap">
		<div class="login-content">
				
			<form method="post">
				<div class="userIcon user">
					<div class="i">
						<i class="fas fa-user"></i>
					</div>
					
					<div class="div">
						<h5>User</h5>
						<input type="text" class="input">				
					</div>
				</div>
				<div class="userIcon lock">
					<div class="i">
						<i class="fas fa-lock"></i>
					</div>
					
					<div class="div">
						<h5>PassWord</h5>
							<input type="password" class="input">
					</div>
				</div>
				<button type="button" class="btn" onclick="send();">Login</button>
			</form>
			
		</div>
	</div>
</body>
</html>