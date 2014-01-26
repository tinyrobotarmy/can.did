class Candid.Views.Day extends Support.CompositeView
  tagName: "li"
  className: "day"
  template: JST["day"]

  initialize: (options) ->
    @selected = options.selected
    @eventEditing = false
    @heading = options.heading
    @collection.bind('add', @render, @)
    @collection.bind('remove', @render, @)

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
      view.on('calendarEvent:moveCompleted', @moveCompleted, @)
      @$el.find("ul.hours").append view.$el

  renderEvents: ->
    for calendarEvent in @collection.toArray()
      @renderEvent(calendarEvent)

  renderEvent: (calendarEvent) ->
    view = new Candid.Views.CalendarEvent(model: calendarEvent)
    view.on('calendarEvent:edit', @editEvent, @)
    view.on('calendarEvent:moving', @moveEvent, @)
    @renderChild view
    @$el.find('ul.hours').append view.$el

  createEvent: (calendarEvent) ->
    if @isToday(calendarEvent.startDate()) && !@eventEditing
      @renderEvent(calendarEvent)
      @trigger('calendarEvent:create', calendarEvent)

  editEvent: (calendarEvent) ->
    if @isToday(calendarEvent.startDate()) && !@eventEditing
      @trigger('calendarEvent:create', calendarEvent)

  moveEvent: (calendarEvent) ->
    if @isToday(calendarEvent.startDate()) && !@eventEditing
      @trigger('calendarEvent:moving', calendarEvent)

  moveCompleted: (dropDate) ->
    if @isToday(dropDate)
      @trigger('calendarEvent:moveCompleted', dropDate)

  eventEditStarted: (event) ->
    @eventEditing = true

  eventCreated: (calendarEvent) ->
    if @isToday(calendarEvent.startDate())
      @collection.add(calendarEvent)
      @eventEditComplete(calendarEvent)
    @eventEditing = false

  eventEditComplete: (calendarEvent) ->
    @eventEditing = false
    @render()

  isToday: (date) ->
    date.clone().clearTime().diffDays(@model) == 0

  removeEvent: (calendarEvent) ->
    @collection.remove(calendarEvent)

  addEvent: (calendarEvent) ->
    @collection.add(calendarEvent)
