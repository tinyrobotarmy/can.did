class Candid.Models.CalendarEvent extends Backbone.Model
  startDate: ->
    new XDate(@.get('start_date'))

  endDate: ->
    new XDate(@.get('end_date'))