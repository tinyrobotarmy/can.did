class Candid.Models.CalendarEvent extends Backbone.Model
  formatWithTime = 'yyyy-MM-dd hh:mm:ss'
  formatWithoutTime = 'yyyy-MM-dd hh'
  startDate: ->
    @_startDate ||= new XDate(@.get('start_date'))

  setStartDate: (newDate) ->
    @.set('start_date', newDate.toString(@formatWithTime))
    @_startDate = newDate

  endDate: ->
    @_endDate ||= new XDate(@.get('end_date'))

  setEndDate: (newDate) ->
    @.set('end_date', newDate.toString(@formatWithTime))
    @_endDate = newDate

  durationInHours: ->
    @startDate().diffHours(@endDate())
