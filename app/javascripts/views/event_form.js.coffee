class Candid.Views.EventForm extends Support.CompositeView
  className: 'popover fade right in'
  template: JST['event_form']

  events: {
    'click .btn-primary': 'save'
    'click .cancel': 'cancel'
  }

  initialize: (options) ->
    @modelBinder = new Backbone.ModelBinder()
    @modelBindings = title: '[name=title]', description: '[name=details]'
    @x = options.x - 125
    @y = options.y - 50

  render: ->
    @$el.html(@template())
    @$el.attr('style', 'left: ' + @x + 'px; top: ' + @y + 'px')
    @modelBinder.bind @model, @$el, @modelBindings
    @$el.slideDown('fast')
    @

  save: (event) ->
    # @model.save()
    @trigger('calendarEvent:created', @model)
    false

  cancel: (event) ->
    @trigger('calendarEvent:cancel', @model)
    false
