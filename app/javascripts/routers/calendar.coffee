class Candid.Routers.Calendar extends Backbone.Router
  initialize: (options) ->
    @events = options.events

  routes: {
    "": "week"
  },

  start: () ->

  week: ->
    view = new Candid.Views.Week({collection: this.events, selectedDate: new XDate(), militaryTime: true})
    $('#candid').html(view.render().$el)
