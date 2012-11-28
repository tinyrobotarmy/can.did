Candid.Routers.Calendar = Backbone.Router.extend({
  initialize: function(options) {
    this.events = options.events;
  },

  routes: {
    "": "week"
  },

  start: function() {},

  week: function() {
    var view = new Candid.Views.Week({collection: this.events, startDate: new XDate()});
    $('#candid').html(view.render().$el);
  }

});