class Candid.Views.Day extends Support.CompositeView
  tagName: "li"
  className: "day"
  template: JST["day"]

  initialize: (options) ->
    @selected = options.selected
    @eventEditing = false

  render: ->
    @$el.html @template(model: @model)
    @renderHours()
    @renderEvents()
    @$el.addClass('selected') if @selected
    @

  afterRender: ->
    @parent.on('event:editStarted', @eventEditStarted, @)
    @parent.on('event:editCancelled', @eventEditCancelled, @)

  renderHours: ->
    for hour in [1..24]
      view = new Candid.Views.Hour(model: @model.clone().addHours(hour) )
      @renderChild view
      view.on('event:create', @createEvent, @)
      @$el.find("ul.hours").append view.$el

  renderEvents: ->
    for event in @collection
      @renderEvent(event)

  renderEvent: (event) ->
    view = new Candid.Views.Event(model: event)
    @renderChild view
    @$el.find('ul.hours').append view.$el

  createEvent: (event) ->
    unless @eventEditing
      @renderEvent(event)
      @trigger('event:create', event)

  eventEditStarted: (event) ->
    @eventEditing = true

  eventEditCancelled: (event) ->
    @eventEditing = false
    @render()