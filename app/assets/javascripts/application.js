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
// by https://github.com/irae
(function(document,navigator,standalone) {
    // prevents links from apps from oppening in mobile safari
    // this javascript must be the first script in your <head>
    if ((standalone in navigator) && navigator[standalone]) {
        var curnode, location=document.location, stop=/^(a|html)$/i;
        document.addEventListener('click', function(e) {
            curnode=e.target;
            while (!(stop).test(curnode.nodeName)) {
                curnode=curnode.parentNode;
            }
            // Condidions to do this only on links to your own app
            // if you want all links, use if('href' in curnode) instead.
            if('href' in curnode && ( curnode.href.indexOf('http') || ~curnode.href.indexOf(location.host) ) ) {
                e.preventDefault();
                location.href = curnode.href;
            }
        },false);
    }
})(document,window.navigator,'standalone');

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
