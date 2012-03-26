//= require jquery-ui
//= require jquery_ujs
//= require jquery.pjax
//= require jquery.purr
//= require best_in_place
//= require rails.validations
//= require jquery.jqplot.min
//= require jqplot.highlighter.min
//= require jqplot.cursor.min
//= require jqplot.dateAxisRenderer.min
//= require jqplot.pieRenderer
//= require jqplot.barRenderer.min
//= require jqplot.categoryAxisRenderer.min
//= require jqplot.pointLabels.min
//= require bar-chart
//= require bootstrap
//= require jquery.mailcheck.min
//= require showdown
//= require_self

//prevent ipad webapps opening in safari
var iWebkit;if(!iWebkit){iWebkit=window.onload=function(){function fullscreen(){var a=document.getElementsByTagName("a");for(var i=0;i<a.length;i++){if(a[i].className.match("noeffect")){}else{a[i].onclick=function(){window.location=this.getAttribute("href");return false}}}}function hideURLbar(){window.scrollTo(0,0.9)}iWebkit.init=function(){fullscreen();hideURLbar()};iWebkit.init()}}


$(function(){
	if(window.location.pathname === "/"){
		//do nothing
	}else{
		// pjax
		$('.js-pjax').pjax('#pjax-contain');
		$('body').bind('pjax:end',   function() { 
				//$(document).ready();
				load_scripts();
			})
	}
	load_scripts();
	
	
})

function load_scripts(){
  	$('.dropdown-toggle').dropdown();
	$('.tooltip-class').tooltip();
	$('.popover-class').popover();
	$('.model-class').modal({
	  show: false,
	backdrop: false
	});
	$(".best_in_place").best_in_place();
	$.datepicker.setDefaults({
	   dateFormat: 'D, dd M yy' });
}
