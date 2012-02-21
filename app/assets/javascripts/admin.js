//= require refire
//= require jquery-ui
//= require jquery_ujs
//= require jquery.pjax
//= require jquery.purr
//= require best_in_place
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
	$('.tooltip-class').tooltip();
	$(".best_in_place").best_in_place();
	$.datepicker.setDefaults({
	   dateFormat: 'D, dd M yy' });
	
	
})


