#handle modal form submit buttons.
$(".submit-button").click ->
  form_id = $(this).attr("data-form-id")
  $("#" + form_id).submit()
  unless $(".field_with_errors")[0]
    $("#" + form_id).fadeOut "slow", ->
      $("." + form_id + "_bar").fadeIn "slow"