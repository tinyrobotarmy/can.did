class Candid.Views.Week extends Support.CompositeView
  tagName: "div"
  className: "calendar"
  template: JST["week"]
  events: {}
  initialize: (options) ->
    @selectedDate = options.selectedDate
    @startDate = @getStartDate(@selectedDate)

  render: ->
    @$el.html @template()
    @renderDays()
    @setheading()
    this

  renderDays: ->
    for index in [0..6]
      date = new XDate(@startDate).addDays(index)
      view = new Candid.Views.Day(model: date, selected: date.getTime() == @selectedDate.getTime())
      @renderChild view
      @$el.find("ul.week").append view.$el

  getStartDate: (date)->
    new XDate(date).addDays(- date.getDay())

  setheading: ->
    @$el.find('.start-date').html(@startDate.toString('d MMMM'))
    @$el.find('.end-date').html(@startDate.clone().addDays(7).toString('d MMMM'))