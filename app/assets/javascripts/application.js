//= require jquery-ui.min
//= require jquery_ujs
//= require best_in_place
//= require rails.validations
//= require jquery.mailcheck.min
//= require showdown
//= require date
//= require select2
//= require jquery.infinitescroll.min
//= require jquery.masonry
//= require google_maps
//= require Chart
//= require jquery.sparklines
//= require escape_string
//= require_tree ./admin
//= require flat/js/behaviour/core
//= require flat/js/bootstrap/dist/js/bootstrap
//= require flat/js/jquery.datatables/jquery.datatables.min
//= require flat/js/jquery.datatables/bootstrap-adapter/js/datatables
//= require jquery.tooltipster
//= require_self


$(function(){
	"use strict";
	load_scripts();
});

function load_scripts(){
	"use strict";
	$('.dropdown-toggle').dropdown();
	// $('.tooltip-class').tooltip({container: 'body'});
	$('.tipster').tooltipster();
	// $('.popover-class').popover();
	$(".best_in_place").best_in_place();
	$("select").select2();
	$.datepicker.setDefaults({
		dateFormat: 'dd M yy',
		changeMonth: true,
		changeYear: true,
		yearRange: "-50:+10"
	});
	$('table.tablesorter').dataTable();

	// allows select2 to be used in bootstrap modals
	$.fn.modal.Constructor.prototype.enforceFocus = function() {};
}
