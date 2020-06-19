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
				<a href="#"><i class="far fa-address-book"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">일일일일일일</a></li>
				<li><a href="#">일일일일일일</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="far fa-comment-alt"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">이이이이이이이</a></li>
				<li><a href="#">이이이이이이이</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="far fa-address-book"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">삼삼삼삼삼삼</a></li>
				<li><a href="#">삼삼삼삼삼삼</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="<%=cp%>/sign/mainList"><i class="fas fa-file-signature"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">사사사사사사</a></li>
				<li><a href="#">사사사사사사</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="fas fa-calendar-alt"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">오오오오오오</a></li>
				<li><a href="#">오오오오오오</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="<%=cp%>/community/list"><i class="fas fa-users"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">육육육육육육</a></li>
				<li><a href="#">육육육육육육</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="<%=cp%>/notice/list"><i class="fas fa-bullhorn"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">칠칠칠칠칠칠</a></li>
				<li><a href="#">칠칠칠칠칠칠</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="#"><i class="fas fa-user-clock"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">팔팔팔팔팔팔</a></li>
				<li><a href="#">팔팔팔팔팔팔</a></li>
			</ul>
		</li>
		
		<li>
			<div class="menu-icon">
				<a href="<%=cp%>/data/list"><i class="fas fa-download"></i></a>
			</div>
			<ul class="sub-menu">
				<li><a href="#">구구구구구구</a></li>
				<li><a href="#">구구구구구구</a></li>
			</ul>
		</li>
	</ul>
</div>
