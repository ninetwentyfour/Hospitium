//= require jquery_ujs
//= require jquery.pjax
//= require_self
//= require bootstrap

$(function(){
	if(window.location.pathname === "/"){
		//do nothing
	}else{
		// pjax
		$('.js-pjax').pjax('#pjax-contain');
	}
	$('.dropdown-toggle').dropdown();
	$('.tooltip-class').tooltip();
})


