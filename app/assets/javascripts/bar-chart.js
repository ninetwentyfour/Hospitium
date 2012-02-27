//$.noConflict();
$(document).ready(function() { 
	//$('.count').tooltipsy({});
	//$('.count').tipsy();
	var cntt = 0;
	$(".barAnimal").each(function () {
				z = cntt++;
				var hue = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
				$(this).find('.countAnimal').css("background-color", hue);
				var label = $(this).find('.labelAnimal').text();
				var random = (Math.floor(Math.random() * 256));
				var random2 = (Math.floor(Math.random() * 206));
				$(this).attr("data-animate-label", "barchart_animal_species_"+random+"_"+random2);
				$('#chartKey').append('<li id="barchart_animal_species_'+random+'_'+random2+'"><div class="circle" style="width:10px;height:10px;margin-top:2px;background-color:'+hue+';"></div>'+label+'</li>');
   });
	$('.countAnimal').each(function() {
	  var bar_width;
	  bar_width = $(this).attr("data-animate-length");
		if(bar_width == "0%"){
			bar_width = "2%";
		}
		//$(this).tipsy({gravity: 'e'});
	  $(this).animate({height: bar_width,opacity: 1}, 1500, "swing" );
	});
	//.mouseenter() 
	$(".barAnimal").mouseenter(function(){
		var bar_width;
	  	bar_width = $(this).attr("data-animate-label");
		$('#'+bar_width).css("font-weight", "600");
		$('#'+bar_width).find('.circle').css("box-shadow", "0 0 5px #333");
	});
	$(".barAnimal").mouseleave(function(){
		var bar_width;
	  	bar_width = $(this).attr("data-animate-label");
		$('#'+bar_width).css("font-weight", "400");
		$('#'+bar_width).find('.circle').css("box-shadow", "0 0 0px #333");
	});
	
	$(".barAnimal2").each(function () {
				var hue = 'rgb(' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ',' + (Math.floor(Math.random() * 256)) + ')';
				$(this).find('.countAnimal2').css("background-color", hue);
				var label = $(this).find('.labelAnimal2').text();
				var random = (Math.floor(Math.random() * 256));
				var random2 = (Math.floor(Math.random() * 206));
				$(this).attr("data-animate-label", "barchart_animal_species_"+random+"_"+random2);
				$('#chartKey2').append('<li id="barchart_animal_species_'+random+'_'+random2+'"><div class="circle" style="width:10px;height:10px;margin-top:2px;background-color:'+hue+';"></div>'+label+'</li>');
   });
	$('.countAnimal2').each(function() {
	  var bar_width;
	  bar_width = $(this).attr("data-animate-length");
		if(bar_width == "0%"){
			bar_width = "2%";
		}
		//$(this).tipsy({gravity: 'e'});
	  $(this).animate({height: bar_width,opacity: 1}, 1500, "swing" );
	});
	
	$(".barAnimal2").mouseenter(function(){
		var bar_width;
	  	bar_width = $(this).attr("data-animate-label");
		$('#'+bar_width).css("font-weight", "600");
		$('#'+bar_width).find('.circle').css("box-shadow", "0 0 5px #333");
	});
	$(".barAnimal2").mouseleave(function(){
		var bar_width;
	  	bar_width = $(this).attr("data-animate-label");
		$('#'+bar_width).css("font-weight", "400");
		$('#'+bar_width).find('.circle').css("box-shadow", "0 0 0px #333");
	});
});