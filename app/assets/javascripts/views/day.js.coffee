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
    @parent.on('calendarEvent:editCancelled', @eventEditComplete, @)
    @parent.on('calendarEvent:editCreated', @eventCreated, @)

  renderHours: ->
    for hour in [0..23]
      view = new Candid.Views.Hour(model: @model.clone().addHours(hour) )
      @renderChild view
      view.on('calendarEvent:create', @createEvent, @)
      @$el.find("ul.hours").append view.$el

  renderEvents: ->
    for calendarEvent in @collection
      @renderEvent(calendarEvent)

  renderEvent: (calendarEvent) ->
    view = new Candid.Views.CalendarEvent(model: calendarEvent)
    view.on('calendarEvent:edit', @editEvent, @)
    @renderChild view
    @$el.find('ul.hours').append view.$el

  createEvent: (calendarEvent) ->
    if @isToday(calendarEvent.startDate()) && !@eventEditing
      @renderEvent(calendarEvent)
      @trigger('calendarEvent:create', calendarEvent)

  editEvent: (calendarEvent) ->
    if @isToday(calendarEvent.startDate()) && !@eventEditing
      @trigger('calendarEvent:create', calendarEvent)

  eventEditStarted: (event) ->
    @eventEditing = true

  eventCreated: (calendarEvent) ->
    if @isToday(calendarEvent.startDate())
      @collection.push(calendarEvent)
      @eventEditComplete(calendarEvent)
    @eventEditing = false

  eventEditComplete: (calendarEvent) ->
    @eventEditing = false
    @render()

  isToday: (date) ->
    date.clone().clearTime().diffDays(@model) == 0
