bar_chart = ->
  cntt = 0
  
  #create the key of the bar chart
  $(".barchart").each ->
    $(this).find("li.barAnimal").each ->
      z = cntt++
      hue = "rgb(" + (Math.floor(Math.random() * 256)) + "," + (Math.floor(Math.random() * 256)) + "," + (Math.floor(Math.random() * 256)) + ")"
      $(this).find(".countAnimal").css "background-color", hue
      label = $(this).find(".labelAnimal").text()
      random = (Math.floor(Math.random() * 256))
      random2 = (Math.floor(Math.random() * 206))
      $(this).attr "data-animate-label", "barchart_animal_species_" + random + "_" + random2
      $(this).parent().parent().children(".chartKey-bar").append "<li id=\"barchart_animal_species_" + random + "_" + random2 + "\"><div class=\"circle\" style=\"width:10px;height:10px;background-color:" + hue + ";\"></div>" + label + "</li>"


  
  #animate bars
  $(".countAnimal").each ->
    bar_width = undefined
    bar_width = $(this).attr("data-animate-length")
    bar_width = "2%"  if bar_width is "0%"
    $(this).animate
      height: bar_width
      opacity: 1
    , 1500, "swing"

  
  #handle hovers
  $(".barAnimal").mouseenter ->
    bar_width = undefined
    bar_width = $(this).attr("data-animate-label")
    $("#" + bar_width).css "font-weight", "600"
    $("#" + bar_width).find(".circle").css "box-shadow", "0 0 5px #333"

  $(".barAnimal").mouseleave ->
    bar_width = undefined
    bar_width = $(this).attr("data-animate-label")
    $("#" + bar_width).css "font-weight", "400"
    $("#" + bar_width).find(".circle").css "box-shadow", "0 0 0px #333"
window.bar_chart = bar_chart