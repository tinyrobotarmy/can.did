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
    @trigger('calendarEvent:create', new Candid.Models.CalendarEvent({
        start_date:@model.toString('YYYY-MM-dd H:mm'),
        end_date: @model.clone().addHours(1).toString('YYYY-MM-dd H:mm'),
        title: 'New Event',
        clientX: event.clientX,
        clientY: event.clientY
      }))
