class Candid.Views.Week extends Support.CompositeView
  tagName: "div"
  className: "calendar"
  template: JST["week"]
  events: {
    'click a.previous': 'previous'
    'click a.today': 'today'
    'click a.next': 'next'
  }
  initialize: (options) ->
    @selectedDate = options.selectedDate
    @militaryTime = options.militaryTime
    @startDate = @getStartDate(@selectedDate)
    @eventForm = null
    $(document).keyup (event) =>
      @keyListener(event)

  render: ->
    @$el.html @template()
    @renderLabels()
    @renderDays()
    @setHeading()
    @

  renderLabels: ->
    @$el.find("ul.days").append('<li class="labels"><div class="heading"></div><ul class="unstyled"></ul></li>')
    for hour in [0..23]
      view = new Candid.Views.Label(model: hour.toString(), militaryTime: @militaryTime )
      @renderChild view
      @$el.find("li.labels>ul").append view.$el

  renderDays: ->
    @dayViews = {}
    for index in [0..6]
      date = new XDate(@startDate.getFullYear(), @startDate.getMonth(), @startDate.getDate(), 0,0,0).addDays(index)
      $heading = $('<li></li>').appendTo(@$el.find("ul.day-headings"))
      view = new Candid.Views.Day(model: date, selected: date.getTime() == @selectedDate.getTime(), collection: @collection.forDate(date), heading: $heading)
      @renderChild view
      view.afterRender()
      view.on('calendarEvent:create', @showEventForm, @)
      view.on('calendarEvent:moving', @moveEvent, @)
      view.on('calendarEvent:moveCompleted', @moveCompleted, @)
      @$el.find("ul.days").append view.$el
      @dayViews[date.toString('yyyy-MM-dd')] = view

  getStartDate: (date)->
    new XDate(date).addDays(- date.getDay())

  setHeading: ->
    @$el.find('.start-date').html(@startDate.toString('d MMMM'))
    @$el.find('.end-date').html(@startDate.clone().addDays(6).toString('d MMMM'))

  next: ->
    @startDate.addDays(7)
    @render()

  previous: ->
    @startDate.addDays(-7)
    @render()

  today: ->
    @startDate = @getStartDate(@selectedDate)
    @render()

  moveEvent: (calendarEvent) ->
    @eventMoving = calendarEvent

  moveCompleted: (startDate) ->
    duration = @eventMoving.durationInHours()
    @dayViews[@eventMoving.startDate().toString('yyyy-MM-dd')].removeEvent(@eventMoving)
    @eventMoving.setStartDate(startDate)
    @eventMoving.setEndDate(startDate.clone().addHours(duration))
    @dayViews[startDate.toString('yyyy-MM-dd')].addEvent(@eventMoving)

  showEventForm: (calendarEvent) ->
    @eventForm = new Candid.Views.EventForm(x: calendarEvent.get('clientX'), y: calendarEvent.get('clientY'), model: calendarEvent)
    @renderChild @eventForm
    @$el.find("div.week").append @eventForm.$el
    @trigger('calendarEvent:editStarted')
    @eventForm.on('calendarEvent:cancel', @cancelEdit, @)
    @eventForm.on('calendarEvent:created', @savedCalendarEvent, @)
    false

  keyListener: (event) ->
    @cancelEdit(@eventForm.model) if event.keyCode == 27

  cancelEdit: (calendarEvent) ->
    @hideForm()
    @trigger('calendarEvent:editCancelled', calendarEvent)

  savedCalendarEvent: (calendarEvent) ->
    @collection.add(calendarEvent)
    @trigger('calendarEvent:editCreated', calendarEvent)
    @hideForm()

  hideForm: ->
    if @eventForm
      @eventForm.$el.fadeOut('fast')
      @eventForm.leave()
      @eventForm = null
