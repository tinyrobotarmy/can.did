window.Candid =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: (data) ->
    new Candid.Routers.Calendar(events: data.events)
    unless Backbone.history.started
      Backbone.history.start()
      Backbone.history.started = true

  infoMessage: (message) ->
    window.messageBox.showInfoMessage message

  errorMessage: (message) ->
    window.messageBox.showErrorMessage message

window.messageBox = new MessageBox($('.message-box'))