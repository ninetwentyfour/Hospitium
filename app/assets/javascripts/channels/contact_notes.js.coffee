contact_note_cable_listen = (id, model, url = model) ->
  cable = ActionCable.createConsumer()

  cable.subscriptions.create({
    channel: 'NotesChannel'
    id: id
  },
    received: (data) ->
      console.log data
      converter = new Showdown.converter()
      obj = JSON.parse(data.record)

      bg_color = ""
      updated_text = "There was an update, but a problem displaying. Please refresh."

      $("#animal_notes_list").append "<li id=\"note_" + obj.id + "\"><strong>" + data.user + "</strong> " + obj.created_at + " <br />" + converter.makeHtml(obj.note) + "</li>"
      $("#animal_notes_list").scrollTop $("#animal_notes_list")[0].scrollHeight

      # /* Highlight the new comment */
      $("#note_" + obj.id).css "background-color", "#c7f464"
      if $("#note_" + obj.id).prev("li").css("background-color") is "rgb(255, 255, 255)"
        bg_color = "#f5f5f5"
      else
        bg_color = "#ffffff"
      $("#note_" + obj.id).delay(1500).animate
        backgroundColor: bg_color
      , 1000
      return

    renderMessage: (data) ->
      '<p> <b>' + data.user + ': </b>' + data.message + '</p>'
  )
window.contact_note_cable_listen = contact_note_cable_listen
