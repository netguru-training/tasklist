showPopup = ->
  $('#popup').removeClass('hidden')

hidePopup = ->
  $('#popup').addClass('hidden')

setMessage = (msg) ->
  $('#popup').html(msg)
