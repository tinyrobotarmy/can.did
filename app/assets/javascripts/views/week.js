Candid.Views.Week = Support.CompositeView.extend({
  tagName: 'div',
  className: 'calendar',
  template: JST['week'],

  events: {

  },

  initialize: function(options) {
    this.startDate = options.startDate;
  },

  render: function() {
    this.$el.html(this.template());
    this.renderDays();
    return this;
  },

  renderDays: function() {
    _.each(_.range(7), function(index){
      var view = new Candid.Views.Day({model: this.startDate.addDays(1)});
      this.renderChild(view);
      this.$el.find('ul.week').append(view.$el);
    }, this);
  }
});