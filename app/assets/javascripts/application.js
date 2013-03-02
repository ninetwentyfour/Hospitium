//= require jquery-ui-1.8.18.custom.min
//= require jquery_ujs
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
//= require twitter/bootstrap
//= require jquery.mailcheck.min
//= require jquery.datatables.min
//= require showdown
//= require date
//= require select2
//= require jquery.infinitescroll.min
//= require jquery.masonry
//= require bootstrap-modal
//= require bootstrap-modalmanager
//= require datatables_config
//= require google_maps
//= require_tree ./admin
//= require_self


$(function(){
	"use strict";
	load_scripts();
});

function load_scripts(){
	"use strict";
	$('.dropdown-toggle').dropdown();
	$('.tooltip-class').tooltip();
	$('.popover-class').popover();
	$(".best_in_place").best_in_place();
	$("select").select2();
	$.datepicker.setDefaults({
		dateFormat: 'D, dd M yy',
		changeMonth: true,
		changeYear: true
	});
	$('table.tablesorter').dataTable( {
		"sDom": "<''<'span4'l><'pull-right'f>r>t<''<'span3'i><'span6'p>>",
		"sPaginationType": "bootstrap",
		"oLanguage": {
			"sLengthMenu": "_MENU_ records per page"
		}
	} );
}