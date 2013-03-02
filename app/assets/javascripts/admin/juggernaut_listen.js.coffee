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
    jQuery.each data.record, (i, val) ->
      if i isnt "updated_at"
        updated_text = val[1]
        if $("#best_in_place_#{model}_#{id}_" + i).attr("data-collection") isnt `undefined`
          brand = $("#best_in_place_#{model}_#{id}_" + i).attr("data-collection")
          test = $.parseJSON(brand)
          $.each test, (index, value) ->
            updated_text = value[1]  if value[0] is val[1]
        else if i is "address"
          # refresh map if address updated
          google_map(val[1], val[1])

        $("#best_in_place_#{model}_#{id}_" + i).css("background-color", "#c7f464").html(updated_text).delay(1500).animate
          backgroundColor: "#f5f5f5"
        , 1000
window.juggernaut_listen = juggernaut_listen