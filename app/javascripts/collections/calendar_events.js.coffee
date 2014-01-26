class Candid.Collections.CalendarEvents extends Backbone.Collection
  model: Candid.Models.CalendarEvent

  forDate: (date) ->
    new Candid.Collections.CalendarEvents(@.select (calendarEvent) ->
      date.getFullYear() == calendarEvent.startDate().getFullYear() &&
      date.getMonth() == calendarEvent.startDate().getMonth() &&
      date.getDate() == calendarEvent.startDate().getDate())
