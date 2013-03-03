animal_show = ->
  animal_uuid = $("#animal_holder").data("animal_uuid")
  animal_id = $("#animal_holder").data("animal_id")
  
  #setup juggernaut to handle real time updating page changes
  #this one handles changes made with best in place
  jug = new Juggernaut(
    secure: true
    host: "juggernaut-hospitium2.herokuapp.com"
    port: 443
    transports: ["xhr-polling", "jsonp-polling"]
  )
  jug.subscribe "/observer/" + animal_uuid, (data) ->
    "use strict"
    updated_text = "There was an update, but a problem displaying. Please refresh."
    jQuery.each data.record, (i, val) ->
      if i isnt "updated_at"
        updated_text = val[1]
        if $("#best_in_place_animal_" + animal_id + "_" + i).attr("data-collection") isnt `undefined`
          brand = $("#best_in_place_animal_" + animal_id + "_" + i).attr("data-collection")
          test = $.parseJSON(brand)
          $.each test, (index, value) ->
            updated_text = value[1]  if value[0].toString() is val[1].toString()

        else if Date.parse(updated_text)
          d = new Date(updated_text)
          d.setDate d.getDate() + 1
          updated_text = dateFormat(d, "ddd, mmm d yyyy")
        $("#best_in_place_animal_" + animal_id + "_" + i).css("background-color", "#c7f464").html(updated_text).delay(1500).animate
          backgroundColor: "#f5f5f5"
        , 1000


  jug.subscribe "/observer/note/" + animal_id, (data) ->
    "use strict"
    bg_color = ""
    updated_text = "There was an update, but a problem displaying. Please refresh."
    jQuery.each data.record, (i, val) ->
      $("#animal_notes_list").append "<li id=\"note_" + val.id + "\"><strong>" + data.user + "</strong> " + data.created_at + " <br />" + val.note + "</li>"
      $("#animal_notes_list").scrollTop $("#animal_notes_list")[0].scrollHeight
      
      # /* Highlight the new comment */
      $("#note_" + val.id).css "background-color", "#c7f464"
      if $("#note_" + val.id).prev("li").css("background-color") is "rgb(255, 255, 255)"
        bg_color = "#f5f5f5"
      else
        bg_color = "#ffffff"
      $("#note_" + val.id).delay(1500).animate
        backgroundColor: bg_color
      , 1000


  
  #create the date picker for adding an animal weight
  $("#animal_weight_date_of_weight").datepicker()
  $.datepicker.setDefaults dateFormat: "D, dd M yy"


  $("a[data-toggle=\"tab\"]").on "shown", (e) ->
    "use strict"
    unless $("canvas").length # implies *not* zero
      #do nothing
      line1 = $("#animal_weights_holder").data("animal_weights")
      plot1 = $.jqplot("chart1", [line1],
        title: "Animal Weight"
        grid:
          background: "#FCF8E3"
          gridLineColor: "#FBEED5" # *Color of the grid lines.
          borderColor: "#DDD" # CSS color spec for border around grid.
          shadow: false

        seriesDefaults:
          color: "#49AFCD" # CSS color spec to use for the line.  Determined automatically.

        axes:
          xaxis:
            renderer: $.jqplot.DateAxisRenderer
            tickOptions:
              formatString: "%b&nbsp;%#d"

          yaxis: {}

        highlighter:
          show: true
          sizeAdjust: 7.5

        cursor:
          show: false
      )
window.animal_show = animal_show