class Candid.Views.Label extends Support.CompositeView
  tagName: 'li'
  className: 'hour-label'

  events: { }

  initialize: (options) ->
    @militaryTime = options.militaryTime

  render: ->
    if @militaryTime
      @$el.html(@militaryHour())
    else
      @$el.html(@clockHour())
    @

  militaryHour: ->
    @model + ':00'

  clockHour: ->
    if @model <= 12
      return @model + ' AM'
    else
      return (@model - 12) + 'PM'