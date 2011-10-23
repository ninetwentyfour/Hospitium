jQuery.noConflict();

jQuery('button').bind('click', function(e) { 
	jQuery( "#loadingBlock" ).attr('style', 'visibility:visible;');
});
jQuery('a').bind('click', function(e) { 
	jQuery( "#loadingBlock" ).attr('style', 'visibility:visible;');
});