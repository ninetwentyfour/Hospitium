//= require jquery_ujs
//= require jquery.pjax
//= require_self

$(function(){
	if(window.location.pathname === "/"){
		//do nothing
	}else{
		// pjax
		$('.js-pjax').pjax('#pjax-contain');
	}
})


