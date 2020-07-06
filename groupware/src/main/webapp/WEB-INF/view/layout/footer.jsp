<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
/*footer*/
.footer {
	background: transparent;
 	position: fixed;
 	left: 0;
    bottom: 0;
}
.footer-icon {  	
	font-size: 30px;
	color: fuchsia;
	padding: 10px 0 10px 27.5px ;
	
}

#footericon {
	height:60px;
	line-height:60px;
	background: gold;
}
.fixedIcon{
	
	font-size: 30px;
	margin-left:25px;
	margin-right: 25px;
}

.footer-profile{
	position: absolute;

}

.fp-dept{
	font-size:20px;
	padding: 10px 0 0 10px;
}

.fp-person{
	 padding: 5px 0 5px 20px;
	 font-size: 18px;
}

.footer-chatTB, .footer-messageTB{
	display: none;
}

.chat-title, .msg-title{
	padding-left: 10px;
	padding-top: 10px
}



</style>

<script>
$(function(){
	$(".footer-icon").click(function(){
		$(".footer-detail").toggle(100);
	});

});

$(function(){
	
	$(".header1").on("click",function(){
		$(".footer-profileTB").css("display", "inline-block");
		$(".footer-chatTB").css("display", "none");
		$(".footer-messageTB").css("display", "none");
	});
	
	$(".header2").on("click",function(){
		$(".footer-profileTB").css("display", "none");
		$(".footer-chatTB").css("display", "inline-block");
		$(".footer-messageTB").css("display", "none");
	});
	
	$(".header3").on("click",function(){
		$(".footer-profileTB").css("display", "none");
		$(".footer-chatTB").css("display", "none");
		$(".footer-messageTB").css("display", "inline-block");
	});
	
	
});



</script>
<script>
$(function(){
	$(".dept-icon").on("click",function(){
	  var obj = $(this);
	  if( obj.hasClass("fp-dept-more") ){
	    obj.hide();
	    obj.next().show();            
	    obj.parent().parent().next().show();
	  }else{
	     obj.hide();
	     obj.prev().show();
	     obj.parent().parent().next().hide();
	  }
	});
});

/* $(function(){
	$(".dept-icon").click(function(){
		if($(this).hasClass("fp-dept-more") ){
			$(this).css("display", "none");
			$('.fp-dept-less').css("display", "");		
			$('.fp-person').css("display", "");
		} else{
			$(this).css("display", "");
			$('.fp-dept-less').css("display", "none");							
			$('.fp-person').css("display", "none");
			$('.fp-dept-more').css("display", "");	
		}	
	});
}); */


/* 
$(".dept-icon").click(function(){
	  var obj = $(this);
	  if( obj.hasClass("fdc-dept-more") ){
	    obj.hide();
	    obj.next().show();            
	    obj.parent().parent().next().show();
	  }else{
	     obj.hide();
	     obj.prev().show();
	     obj.parent().parent().next().hide();
	  }
	}); */
</script>

<div class="footer">
	<div class="footer-detail"style="background: aqua; width: 300px; height: 410px; display: none;">
		<div class="footer-detail-top">
				
			<div id="footericon" style="text-align: center; line-height: 60px;">
				<a class="fixedIcon header1"><span><i class="fas fa-user"></i></span></a>
				<a class="fixedIcon header2"><span><i class="fas fa-comments"></i></span></a>
				<a class="fixedIcon header3"><span><i class="fas fa-paper-plane"></i></span></a>
			</div>
		
			<div class="footer-detail-content" style="width: 300px; height: 350px; text-align: left; overflow: auto ">
				<div class="footer-profile" style="width: 300px; height: 340px; overflow: auto; display: inline-block; ">				
					<table class="footer-profileTB" style="/* display: none; */">
						<tr >
		   					<td class="fp-dept">
		   						<span class="dept-icon fp-dept-more "><i class="fas fa-caret-down"></i>부서이름쓰세욘</span>
		         				<span class="dept-icon fp-dept-less " style="display:none"><i class="fas fa-caret-up"></i>부서이름쓰세욘</span> 
		         			</td>
		  				</tr>
		  				<tr style="display:none;">
		    				<td  class="fp-person" >
		    					<p> <i class="fas fa-circle" style="font-size: 8px"></i>&nbsp;&nbsp;&nbsp;
		    						<i class="fas fa-user-circle"></i>ㅇㅇㅇ부장
		    						<a class="chatInput"><span><i class="fas fa-comments"></i></span></a>
		    						<a class="messageInput"><span><i class="fas fa-paper-plane"></i></span></a>
		    						<a class="information"><span><i class="fas fa-info-circle"></i></span></a>	    						
		    					</p>
		    				</td>
		  				</tr>
		  				
					</table>														
				</div>	
				
				
				<div class="footer-chat">
					<p class="footer-chatTB chat-title" style="display: none;">대화하하하하</p>
					<table class="footer-chatTB" style="border-bottom: 1px solid red; width: 280px; margin-left: 10px; padding: 10px;  " >
						<tr>
							<td rowspan="2"><i style="font-size: 35px;" class="fas fa-user-circle"></i></td>
							<td><p>홍보부 김수현 사원</p></td>
						</tr>
						<tr>							
							<td style="color:red"><p>대화내용이요~~</p></td>
						</tr>
					</table>
				</div>
				
				<div class="footer-message">
					<p class="footer-messageTB msg-title" >받은쪽지함</p>
					<table class="footer-messageTB" style="border-bottom: 1px solid red; width: 280px; margin-left: 10px; padding: 10px; " >
						<tr>
							<td rowspan="2"><i style="font-size: 35px;" class="fas fa-user-circle"></i></td>
							<td><p>홍보부 김수현 사원</p></td>
						</tr>
						<tr>							
							<td style="color:plum"><p>쪽지요~~~</p></td>
						</tr>
					</table>
				</div>
			</div>			
			
		</div>
		
	</div>
	
	
	<div class="footer-icon">
		<a><i class="fas fa-columns"></i></a>
	</div>
	
	
	
</div>