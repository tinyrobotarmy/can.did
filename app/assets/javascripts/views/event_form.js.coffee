class Candid.Views.EventForm extends Support.CompositeView
  className: 'popover fade right in'
  template: JST['event_form']

  initialize: (options) ->
    @modelBinder = new Backbone.ModelBinder()
    @x = options.x - 125
    @y = options.y - 50

  render: ->
    @$el.html(@template())
    @$el.attr('style', 'left: ' + @x + 'px; top: ' + @y + 'px')
    @$el.slideDown('fast')
    @
