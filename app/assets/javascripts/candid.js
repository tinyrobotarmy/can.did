window.Candid = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function(data){

    new Candid.Routers.Calendar({events: data.events});

    if (!Backbone.history.started) {
      Backbone.history.start();
      Backbone.history.started = true;
    }
  },

  infoMessage: function(message){
    window.messageBox.showInfoMessage(message);
  },

  errorMessage: function(message){
    window.messageBox.showErrorMessage(message);
  }
};