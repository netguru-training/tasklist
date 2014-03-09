getPopup = -> $('#popup')

showPopup = ->
  getPopup().removeClass('hidden')

hidePopup = ->
  getPopup().addClass('hidden')

setLink = (link) ->
  getPopup().find('.link').html(link)

showLink = (link) ->
  setLink(link)
  showPopup()

fetchShareLink = (listId) ->
  $.ajax("http://localhost:3000/lists/#{ listId }/share_link")

handleShareClick = (e) ->
  e.preventDefault()
  listId = $(e.target).attr('data-list-id')
  fetchShareLink(listId).then( (response) -> showLink(response.url) )

handlePopupMsgClick = ->
  selectText('#popup .link')

attachCloseButtonHandler = ->
  closeButton = getPopup().find('.close_button')
  closeButton.on('click', hidePopup)

attachSelectPopupMsgHandler = ->
  getPopup().find('.msg').on('click', handlePopupMsgClick)

selectText = (query) ->
  doc = document
  text = $(query)[0]

  if doc.body.createTextRange # IE
    range = doc.body.createTextRange()
    range.moveToElementText(text)
    range.select()
  else if window.getSelection # rest
    selection = window.getSelection()
    range = doc.createRange()
    range.selectNodeContents(text)
    selection.removeAllRanges()
    selection.addRange(range)

$(->
  $('[data-list-id]').on('click', handleShareClick)
  attachCloseButtonHandler()
  attachSelectPopupMsgHandler()
)
