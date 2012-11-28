Candid.Views.Day = Support.CompositeView.extend({
  tagName: 'li',
  className: 'day',
  template: JST['day'],

  events: {

  },

  initialize: function(options) {
  },

  render: function() {
    this.$el.html(this.template({model: this.model}));
    this.renderHours();
    return this;
  },

  renderHours: function() {
    _.each(_.range(24), function(index){
      var view = new Candid.Views.Hour({model: index + 1});
      this.renderChild(view);
      this.$el.find('ul.hours').append(view.$el);
    }, this);
  }
});