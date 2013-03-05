class @MessageBox
  constructor: (@messageBox) ->
    @closer = @messageBox.find("a.close")
    @closer.click $.proxy(@close, this)
    @open()  if @messageBox.children().length > 1

  close: ->
    @messageBox.fadeOut 400
    false

  open: ->
    @messageBox.fadeIn 400

  showErrorMessage: (message) ->
    @showMessage message, "alert"

  showInfoMessage: (message) ->
    @showMessage message, "notice"

  showMessage: (message, cssClass) ->
    @messageBox.find("div").remove()
    @messageBox.append "<div class=\"" + cssClass + "\">" + message + "</div>"
    @open()
    @messageBox.delay(2000).fadeOut "slow"