class Candid.Views.Event extends Support.CompositeView
  className: 'event'
  template: JST['event']

  initialize: (options) ->
    @modelBinder = new Backbone.ModelBinder()
    @bindings = title: '.title', description: '.description'

  render: ->
    @$el.html(@template())
    @modelBinder.bind @model, @$el, @bindings
    @
