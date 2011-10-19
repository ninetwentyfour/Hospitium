jQuery.noConflict();
jQuery('.bar').each(function() {
  var bar_width;
  bar_width = jQuery(this).attr("data-animate-length");
  jQuery(this).animate({width: bar_width,opacity: 1}, 1500, "swing" );
});