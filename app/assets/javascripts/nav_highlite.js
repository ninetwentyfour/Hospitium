jQuery.noConflict();
jQuery(document).ready(function() {
//bold the navigation for the current page
var textTest = jQuery('#hiddenForNavHighlightInput').val();
if (textTest == "s"){
jQuery('#dashboard_nav').attr('style', 'font-weight:600');
}else{
var linkDiv = '#'+textTest+'_nav';
jQuery(linkDiv).attr('style', 'font-weight:600');
}
});