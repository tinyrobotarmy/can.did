Candid.Views.Hour = Support.CompositeView.extend({
  tagName: 'li',
  className: 'hour',

  events: {

  },

  initialize: function(options) {
  },

  render: function() {
    this.$el.html('hour ' + this.model);
    return this;
  }
});