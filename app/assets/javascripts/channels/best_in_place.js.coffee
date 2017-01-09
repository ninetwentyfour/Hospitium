hos_cable_listen = (id, model, url = model) ->
  cable = ActionCable.createConsumer()

  cable.subscriptions.create({
    channel: 'BestInPlaceChannel'
    id: id
  },
    received: (data) ->
      console.log 'got message'
      console.log data

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

          $("#best_in_place_#{model}_#{id}_#{key}").css("background-color", "#c7f464").html(escapeHtml(updated_text)).delay(1500).animate({backgroundColor: "#fff"}, 1000)

      return

    renderMessage: (data) ->
      '<p> <b>' + data.user + ': </b>' + data.message + '</p>'
  )
window.hos_cable_listen = hos_cable_listen
