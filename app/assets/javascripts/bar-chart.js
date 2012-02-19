jQuery.noConflict();
jQuery(document).ready(function() { 
	//jQuery('.count').tooltipsy({});
	//jQuery('.count').tipsy();
	var cntt = 0;
	jQuery(".barAnimal").each(function () {
				z = cntt++;
				var hue = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
				jQuery(this).find('.countAnimal').css("background-color", hue);
				var label = jQuery(this).find('.labelAnimal').text();
				var random = (Math.floor(Math.random() * 256));
				var random2 = (Math.floor(Math.random() * 206));
				jQuery(this).attr("data-animate-label", "barchart_animal_species_"+random+"_"+random2);
				jQuery('#chartKey').append('<li id="barchart_animal_species_'+random+'_'+random2+'"><div class="circle" style="width:20px;height:20px;background-color:'+hue+';"></div>'+label+'</li>');
   });
	jQuery('.countAnimal').each(function() {
	  var bar_width;
	  bar_width = jQuery(this).attr("data-animate-length");
		if(bar_width == "0%"){
			bar_width = "2%";
		}
		jQuery(this).tipsy({gravity: 'e'});
	  jQuery(this).animate({height: bar_width,opacity: 1}, 1500, "swing" );
	});
	//.mouseenter() 
	jQuery(".barAnimal").mouseenter(function(){
		var bar_width;
	  	bar_width = jQuery(this).attr("data-animate-label");
		jQuery('#'+bar_width).css("font-weight", "600");
		jQuery('#'+bar_width).find('.circle').css("box-shadow", "0 0 5px #333");
	});
	jQuery(".barAnimal").mouseleave(function(){
		var bar_width;
	  	bar_width = jQuery(this).attr("data-animate-label");
		jQuery('#'+bar_width).css("font-weight", "400");
		jQuery('#'+bar_width).find('.circle').css("box-shadow", "0 0 0px #333");
	});
	
	jQuery(".barAnimal2").each(function () {
				var hue = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
				jQuery(this).find('.countAnimal2').css("background-color", hue);
				var label = jQuery(this).find('.labelAnimal2').text();
				var random = (Math.floor(Math.random() * 256));
				var random2 = (Math.floor(Math.random() * 206));
				jQuery(this).attr("data-animate-label", "barchart_animal_species_"+random+"_"+random2);
				jQuery('#chartKey2').append('<li id="barchart_animal_species_'+random+'_'+random2+'"><div class="circle" style="width:20px;height:20px;background-color:'+hue+';"></div>'+label+'</li>');
   });
	jQuery('.countAnimal2').each(function() {
	  var bar_width;
	  bar_width = jQuery(this).attr("data-animate-length");
		if(bar_width == "0%"){
			bar_width = "2%";
		}
		jQuery(this).tipsy({gravity: 'e'});
	  jQuery(this).animate({height: bar_width,opacity: 1}, 1500, "swing" );
	});
	
	jQuery(".barAnimal2").mouseenter(function(){
		var bar_width;
	  	bar_width = jQuery(this).attr("data-animate-label");
		jQuery('#'+bar_width).css("font-weight", "600");
		jQuery('#'+bar_width).find('.circle').css("box-shadow", "0 0 5px #333");
	});
	jQuery(".barAnimal2").mouseleave(function(){
		var bar_width;
	  	bar_width = jQuery(this).attr("data-animate-label");
		jQuery('#'+bar_width).css("font-weight", "400");
		jQuery('#'+bar_width).find('.circle').css("box-shadow", "0 0 0px #333");
	});
});