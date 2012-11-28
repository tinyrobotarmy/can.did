MessageBox = function(messageBox) {
  this.messageBox = messageBox;
  this.closer = this.messageBox.find('a.close');
  this.closer.click($.proxy(this.close, this));
  if(this.messageBox.children().length > 1) {
    this.open();
  }
};

MessageBox.prototype = {
  close: function() {
    this.messageBox.fadeOut(400);
    return false;
  },
  open: function() {
    this.messageBox.fadeIn(400);
  },
  showErrorMessage: function(message) {
    this.showMessage(message, 'alert');
  },
  showInfoMessage: function(message) {
    this.showMessage(message, 'notice');
  },
  showMessage: function(message, cssClass) {
    this.messageBox.find('div').remove();
    this.messageBox.append('<div class="' + cssClass + '">' + message + '</div>');
    this.open();
    this.messageBox.delay(2000).fadeOut('slow');
  }
};

function renderFlash(flashText) {
  window.messageBox.showInfoMessage(flashText);
}