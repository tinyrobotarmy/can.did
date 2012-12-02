class Candid.Collections.Events extends Backbone.Collection
  model: Candid.Models.Event

  forDate: (date) ->
    @.select (event) ->
      date.getFullYear() == event.startDate().getFullYear() &&
      date.getMonth() == event.startDate().getMonth() &&
      date.getDate() == event.startDate().getDate()