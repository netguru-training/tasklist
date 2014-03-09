getPopup = -> $('#popup')

showPopup = ->
  getPopup().removeClass('hidden')

hidePopup = ->
  getPopup().addClass('hidden')

setMessage = (msg) ->
  getPopup().find('.msg').html(msg)

handleShareClick = (e) ->
  e.preventDefault()
  listId = $(e.target).attr('data-list-id')
  setMessage(listId)
  showPopup()

attackCloseButtonHandler = ->
  closeButton = getPopup().find('.close_button')
  closeButton.on('click', hidePopup)

$(->
  $('[data-list-id]').on('click', handleShareClick)
  attackCloseButtonHandler()
)
