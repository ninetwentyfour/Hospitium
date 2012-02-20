(function($, undefined) {
    var isFired = false;
    var oldReady = jQuery.fn.ready;
    $(function() {
        isFired = true;
        $(document).ready();
    });
    jQuery.fn.ready = function(fn) {
        if(fn === undefined) {
            $(document).trigger('_is_ready');
            return;
        }
        if(isFired) {
            window.setTimeout(fn, 1);
        }
        $(document).bind('_is_ready', fn);
    };
})(jQuery);