class Candid.Views.Week extends Support.CompositeView
  tagName: "div"
  className: "calendar"
  template: JST["week"]
  events: {
    'click a.previous': 'previous'
    'click a.today': 'today'
    'click a.next': 'next'
    'click ul.week': 'toggleForm'
  }
  initialize: (options) ->
    @selectedDate = options.selectedDate
    @militaryTime = options.militaryTime
    @startDate = @getStartDate(@selectedDate)
    @eventForm = null

  render: ->
    @$el.html @template()
    @renderLabels()
    @renderDays()
    @setHeading()
    @

  renderLabels: ->
    @$el.find("ul.week").append('<li class="labels"><div class="heading"></div><ul class="unstyled"></ul></li>')
    for hour in [0..23]
      view = new Candid.Views.Label(model: hour.toString(), militaryTime: @militaryTime )
      @renderChild view
      @$el.find("li.labels>ul").append view.$el

  renderDays: ->
    for index in [0..6]
      date = new XDate(@startDate).addDays(index)
      view = new Candid.Views.Day(model: date, selected: date.getTime() == @selectedDate.getTime(), collection: @collection.forDate(date))
      @renderChild view
      @$el.find("ul.week").append view.$el

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

  toggleForm: ->
    if @eventForm == null
      @eventForm = new Candid.Views.EventForm()
      @renderChild @eventForm
      @$el.find("ul.week").append @eventForm.$el
    else
      @eventForm.$el.fadeOut('fast')
      @eventForm.leave()
      @eventForm = null
    false