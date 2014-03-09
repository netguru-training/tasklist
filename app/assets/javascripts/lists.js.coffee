getPopup = -> $('#popup')

getClipBtn = -> $('#clipboard_btn')

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

handleClipboardBtnClick = ->
  getClipBtn().html('Copied!')

attachCloseButtonHandler = ->
  closeButton = getPopup().find('.close_button')
  closeButton.on('click', ->
    hidePopup()
    getClipBtn().html('Click me to copy the link')
  )

attachSelectPopupMsgHandler = ->
  getPopup().find('.msg').on('click', handlePopupMsgClick)

attachClipboardSelectHanlder = (clip) ->
  clip.on('complete', handleClipboardBtnClick)

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
  clip = new ZeroClipboard(getClipBtn())
  attachCloseButtonHandler()
  attachSelectPopupMsgHandler()
  attachClipboardSelectHanlder(clip)
)
