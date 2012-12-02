class Candid.Views.Day extends Support.CompositeView
  tagName: "li"
  className: "day"
  template: JST["day"]

  initialize: (options) ->
    @selected = options.selected

  render: ->
    @$el.html @template(model: @model)
    @renderHours()
    @renderEvents()
    @$el.addClass('selected') if @selected
    @

  renderHours: ->
    for hour in [1..24]
      view = new Candid.Views.Hour(model: hour )
      @renderChild view
      @$el.find("ul.hours").append view.$el

  renderEvents: ->
    for event in @collection
      view = new Candid.Views.Event(model: event)
      @renderChild view
      @$el.find('ul.hours').append view.$el