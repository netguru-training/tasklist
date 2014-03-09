getPopup = -> $('#popup')

showPopup = ->
  getPopup().removeClass('hidden')

hidePopup = ->
  getPopup().addClass('hidden')

setLink = (link) ->
  getPopup().find('.link').attr('href', link)

showLink = (link) ->
  setLink(link)
  showPopup()

fetchShareLink = ->
  $.ajax('http://localhost:3000/lists/531c3d9e4d61635b60020000/share_link')

handleShareClick = (e) ->
  e.preventDefault()
  listId = $(e.target).attr('data-list-id')
  fetchShareLink().then( (response) -> showLink(response.url) )

attackCloseButtonHandler = ->
  closeButton = getPopup().find('.close_button')
  closeButton.on('click', hidePopup)

$(->
  $('[data-list-id]').on('click', handleShareClick)
  attackCloseButtonHandler()
)
