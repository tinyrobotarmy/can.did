class Candid.Views.EventForm extends Support.CompositeView
  className: 'popover fade right in'
  template: JST['event_form']

  initialize: (options) ->
    @modelBinder = new Backbone.ModelBinder()

  render: ->
    @$el.html(@template())
    @$el.slideDown('fast')
    @
