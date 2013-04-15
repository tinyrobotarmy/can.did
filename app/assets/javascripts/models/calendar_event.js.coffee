class Candid.Models.CalendarEvent extends Backbone.Model
  startDate: ->
    @_startDate ||= new XDate(@.get('start_date'))

  endDate: ->
    @_endDate ||= new XDate(@.get('end_date'))

  durationInHours: ->
    @startDate().diffHours(@endDate())
