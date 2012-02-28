//= require refire
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
//= require_self
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
	$('.model-class').modal({
	  show: false,
	backdrop: false
	});
	$(".best_in_place").best_in_place();
	$.datepicker.setDefaults({
	   dateFormat: 'D, dd M yy' });
}
