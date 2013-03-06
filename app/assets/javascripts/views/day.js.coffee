class Candid.Views.Day extends Support.CompositeView
  tagName: "li"
  className: "day"
  template: JST["day"]

  initialize: (options) ->
    @selected = options.selected
    @eventEditing = false
    @heading = options.heading

  render: ->
    @$el.html @template(model: @model)
    @heading.html('<h3>' + @model.toString('d dddd') + '</h3>')
    @renderHours()
    @renderEvents()
    @$el.addClass('selected') if @selected
    @

  afterRender: ->
    @parent.on('calendarEvent:editStarted', @eventEditStarted, @)
    @parent.on('calendarEvent:editCancelled', @eventEditCancelled, @)

  renderHours: ->
    for hour in [1..24]
      view = new Candid.Views.Hour(model: @model.clone().addHours(hour) )
      @renderChild view
      view.on('calendarEvent:create', @createEvent, @)
      @$el.find("ul.hours").append view.$el

  renderEvents: ->
    for calendarEvent in @collection
      @renderEvent(calendarEvent)

  renderEvent: (calendarEvent) ->
    view = new Candid.Views.CalendarEvent(model: calendarEvent)
    @renderChild view
    @$el.find('ul.hours').append view.$el

  createEvent: (calendarEvent) ->
    unless @eventEditing
      @renderEvent(calendarEvent)
      @trigger('calendarEvent:create', calendarEvent)

  eventEditStarted: (event) ->
    @eventEditing = true

  eventEditCancelled: (event) ->
    @eventEditing = false
    @render()
