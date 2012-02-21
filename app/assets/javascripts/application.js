//= require refire
//= require jquery.pjax
//= require_self
//= require bootstrap
$(function(){
	if(window.location.pathname === "/"){
		//do nothing
	}else{
		// pjax
		$('.js-pjax').pjax('#pjax-contain');
		$('body').bind('pjax:end',   function() { 
			$(document).ready();
			})
	}
	
	$('.dropdown-toggle').dropdown();
})


