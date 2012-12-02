//= require jquery-ui-1.8.18.custom.min
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
//= require twitter/bootstrap
//= require jquery.mailcheck.min
//= require showdown
//= require date
//= require select2
//= require jquery.infinitescroll.min
//= require jquery.masonry
//= require_self

//prevent ipad webapps opening in safari
// var iWebkit;if(!iWebkit){iWebkit=window.onload=function(){function fullscreen(){var a=document.getElementsByTagName("a");for(var i=0;i<a.length;i++){if(a[i].className.match("noeffect")){}else{a[i].onclick=function(){window.location=this.getAttribute("href");return false}}}}function hideURLbar(){window.scrollTo(0,0.9)}iWebkit.init=function(){fullscreen();hideURLbar()};iWebkit.init()}}
// (function(document,navigator,standalone) {
//             // prevents links from apps from oppening in mobile safari
//             // this javascript must be the first script in your <head>
//             if ((standalone in navigator) && navigator[standalone]) {
//                 var curnode, location=document.location, stop=/^(a|html)$/i;
//                 document.addEventListener('click', function(e) {
//                     curnode=e.target;
//                     while (!(stop).test(curnode.nodeName)) {
//                         curnode=curnode.parentNode;
//                     }
//                     // Condidions to do this only on links to your own app
//                     // if you want all links, use if('href' in curnode) instead.
//                     if('href' in curnode && ( curnode.href.indexOf('http') || ~curnode.href.indexOf(location.host) ) ) {
//                         e.preventDefault();
//                         location.href = curnode.href;
//                     }
//                 },false);
//             }
//         })(document,window.navigator,'standalone');
$(function(){
	"use strict";
	if(window.location.pathname !== "/"){
		// pjax
		$('.js-pjax').pjax('#pjax-contain');
		$('body').bind('pjax:end',   function() { 
			//$(document).ready();
			load_scripts();
		});
	}
	load_scripts();
	
	
});

function load_scripts(){
	"use strict";
	$('.dropdown-toggle').dropdown();
	$('.tooltip-class').tooltip();
	$('.popover-class').popover();
	$('.model-class').modal({
		show: false,
		backdrop: false
	});
	$(".best_in_place").best_in_place();
	$.datepicker.setDefaults({
		dateFormat: 'D, dd M yy',
		changeMonth: true,
		changeYear: true
	});
}
$(document).ready(function() { $("select").select2(); });
