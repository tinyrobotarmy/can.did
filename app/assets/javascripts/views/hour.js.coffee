class Candid.Views.Hour extends Support.CompositeView
  tagName: 'li'
  className: 'hour'

  events: { 
    'click': 'newEvent'
  }

  initialize: (options) ->

  render: ->
    @

  newEvent: (event) ->
    @trigger('event:create', new Candid.Models.Event({
        start_date:@model.toString('YYYY-MM-dd hh:mm'), 
        end_date: @model.clone().addHours(1).toString('YYYY-MM-dd hh:mm'), 
        title: 'New Event',
        clientX: event.clientX, 
        clientY: event.clientY
      }))