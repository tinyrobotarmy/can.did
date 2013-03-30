class Candid.Views.CalendarEvent extends Support.CompositeView
  className: 'event'
  template: JST['calendar_event']

  events: {
    'click': 'editEvent'
  }

  initialize: (options) ->
    @modelBinder = new Backbone.ModelBinder()
    @bindings = title: '.title', description: '.description'

  render: ->
    @$el.html(@template())
    @modelBinder.bind @model, @$el, @bindings
    @$el.css('top', (@model.startDate().getHours() * 51) + 'px');
    @$el.css('height', (@model.endDate().getHours() - @model.startDate().getHours()) * 51 - 4 + 'px');
    @

  editEvent: (event) ->
    @model.clientX = event.clientX
    @model.clientY = event.clientY
    @trigger('calendarEvent:edit', @model)
