class Candid.Views.CalendarEvent extends Support.CompositeView
  className: 'event'
  template: JST['calendar_event']

  events: {
    'click': 'editEvent', # Maybe double click for editing? click for some type of additional info on focus?
    'dragstart .title': 'dragStart'
    'dragstart': 'resize'
    'dragend': 'dragEnd'
    'mouseup': 'resize'
  }

  initialize: (options) ->
    @modelBinder = new Backbone.ModelBinder()
    @bindings = title: '.title', description: '.description'

  render: ->
    @$el.html(@template())
    @modelBinder.bind @model, @$el, @bindings
    @$el.css('top', (@model.startDate().getHours() * 51) + 'px');
    @$el.css('height', (@model.durationInHours() * 51 - 4 + 'px'));
    # @$el.find('.description').css('height', (@model.durationInHours() * 51 - 24 + 'px'));
    @

  editEvent: (event) ->
    @model.clientX = event.clientX
    @model.clientY = event.clientY
    @trigger('calendarEvent:edit', @model)

  dragStart: (event) ->
    @$el.css('opacity', 0.3)
    @trigger('calendarEvent:moving', @model)

  dragEnd: (event) ->
    @$el.css('opacity', 1)

  resize: (event) ->
    if @$el.height() != @model.durationInHours() * 51 - 4
      @model.setEndDate(@model.startDate().clone().addHours(Math.round(@$el.height() / 51)))
