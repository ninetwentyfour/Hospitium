animal_show = ->
  console.log "test"
  animal_uuid = $("#animal_holder").data("animal_id")
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
    console.log "test"
    jQuery.each data.record, (i, val) ->
      console.log i
      console.log val
      if i isnt "updated_at"
        updated_text = val[1]
        # $('.tab-content').css("background-color", "#c7f464")
        if $("#best_in_place_animal_" + animal_id + "_" + i).attr("data-collection") isnt `undefined`
          brand = $("#best_in_place_animal_" + animal_id + "_" + i).attr("data-collection")
          test = $.parseJSON(brand)
          $.each test, (index, value) ->
            updated_text = value[1]  if value[0].toString() is val[1].toString()

        else if Date.parse(updated_text)
          d = new Date(updated_text)
          d.setDate d.getDate() + 1
          updated_text = dateFormat(d, "ddd, mmm d yyyy")
        # best_in_place_animal_7a4faa46-d4bd-b9a7-82ab-197af4d41143_special_needs
        $("#best_in_place_animal_" + animal_id + "_" + i).css("background-color", "#c7f464").html(escapeHtml(updated_text)).delay(1500).animate
          backgroundColor: "#fff"
        , 1000
        # $("#best_in_place_animal_" + animal_id + "_" + i).css("background-color", "#c7f464").html(escapeHtml(updated_text))


  jug.subscribe "/observer/note/" + animal_id, (data) ->
    "use strict"
    converter = new Showdown.converter()

    bg_color = ""
    updated_text = "There was an update, but a problem displaying. Please refresh."

    $("#animal_notes_list").append "<li id=\"note_" + data.record.id + "\"><strong>" + data.user + "</strong> " + data.created_at + " <br />" + converter.makeHtml(data.record.note) + "</li>"
    $("#animal_notes_list").scrollTop $("#animal_notes_list")[0].scrollHeight

    # /* Highlight the new comment */
    $("#note_" + data.record.id).css "background-color", "#c7f464"
    if $("#note_" + data.record.id).prev("li").css("background-color") is "rgb(255, 255, 255)"
      bg_color = "#f5f5f5"
    else
      bg_color = "#ffffff"
    $("#note_" + data.record.id).delay(1500).animate
      backgroundColor: bg_color
    , 1000



  #create the date picker for adding an animal weight
  $("#animal_weight_date_of_weight").datepicker()
  $("#shot_last_administered").datepicker()
  $("#shot_expires").datepicker({yearRange: "-50:+50"})
  $.datepicker.setDefaults dateFormat: "dd M yy"

  $("a[data-toggle=\"tab\"]").on "show.bs.tab", (e) ->
    $("#canvasWeight").remove()
    $("#weight_graph_holder").append "<canvas id=\"canvasWeight\" height=\"300\" width=\"250\"></canvas>"
    $("#canvasWeight").attr "width", $(".tab-content").width()
    lineChartData =
      labels: $("#animal_weights_holder").data("animal_weights_times")
      datasets: [
        fillColor: "rgba(126,207,213,0.5)"
        strokeColor: "rgba(126,207,213,1)"
        pointColor: "rgba(126,207,213,1)"
        pointStrokeColor: "#fff"
        data: $("#animal_weights_holder").data("animal_weights")
      ]

    myLine = new Chart(document.getElementById("canvasWeight").getContext("2d")).Line(lineChartData)

window.animal_show = animal_show
