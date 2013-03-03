# e.g. model = 'adoption_contact'
# url will default to model name if not passed int
juggernaut_listen = (id, model, url = model) ->
  #setup juggernaut to handle real time updating page changes
  #this one handles changes made with best in place
  jug = new Juggernaut(
    secure: true
    host: "juggernaut-hospitium2.herokuapp.com"
    port: 443
    transports: ["xhr-polling", "jsonp-polling"]
  )
  jug.subscribe "/observer/#{url}/#{id}", (data) ->
    "use strict"
    updated_text = "There was an update, but a problem displaying. Please refresh."
    jQuery.each data.record, (key, val) ->
      if key isnt "updated_at"
        updated_text = val[1]
        if $("#best_in_place_#{model}_#{id}_#{key}").attr("data-collection") isnt `undefined`
          collection = $("#best_in_place_#{model}_#{id}_#{key}").attr("data-collection")
          collection = $.parseJSON(collection)
          $.each collection, (index, value) ->
            updated_text = value[1]  if value[0].toString() is val[1].toString()
        else if key is "address"
          # refresh map if address updated
          google_map(val[1], val[1])

        $("#best_in_place_#{model}_#{id}_#{key}").css("background-color", "#c7f464").html(updated_text).delay(1500).animate({backgroundColor: "#f5f5f5"}, 1000)
window.juggernaut_listen = juggernaut_listen