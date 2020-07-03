<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script type="text/javascript">
	$(function() {
	  var Accordion = function(el, multiple) {
	    this.el = el || {};
	    this.multiple = multiple || false;
	    
	    var dropdownlink = this.el.find('.menu-icon');
	    dropdownlink.on('click',
	                    { el: this.el, multiple: this.multiple },
	                    this.dropdown);
	  };
	  
	  Accordion.prototype.dropdown = function(e) {
	    var $el = e.data.el,
	        $this = $(this),
	        $next = $this.next();
	    
	    $next.slideToggle();
	    $this.parent().toggleClass('open');
	    
	    if(!e.data.multiple) {
	      $el.find('.sub-menu').not($next).slideUp().parent().removeClass('open');
	    }
	  }
	  
	  var accordion = new Accordion($('.menu-bar'), false);
	})
</script>

<div>
	<ul class="menu-bar">
		<li>
			<div class="menu-icon">
				<a href="#"><i class="far fa-comment-alt"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">쪽지</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="far fa-address-book"></i></a>
			</div>
			<ul class="sub-menu">
				<li><p>주소록</p></li>
				<li><a href="<%=cp%>/publicAddr/main">회사</a></li>
				<li><a href="<%=cp%>/privateAddr/main">개인</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="fas fa-file-signature"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="<%=cp%>/sign/mainList">전자결재</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="fas fa-calendar-alt"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="<%=cp%>/scheduler/scheduler">일정</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="fas fa-users"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="<%=cp%>/community/list">커뮤니티</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="fas fa-bullhorn"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="<%=cp%>/notice/list">공지</a></li>
				<li><a href="<%=cp%>/news/list">News</a></li>
				<li><a href="<%=cp%>/food/month">식단표</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="fas fa-user-clock"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">근태관리</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="fas fa-download"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="<%=cp%>/data/list">자료실</a></li>
			</ul>
		</li>
	</ul>
</div>
