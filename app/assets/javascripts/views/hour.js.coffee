class Candid.Views.Hour extends Support.CompositeView
  tagName: 'li'
  className: 'hour'

  events: { }

  initialize: (options) ->

  render: ->
    @$el.html('hour ' + @model)
    @