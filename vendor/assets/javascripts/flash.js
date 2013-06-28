// refactoring from https://github.com/leonid-shevtsov/cacheable-flash-jquery
var Flash = new Object();

Flash.data = {};

Flash.transferFromCookies = function() {
  var data = JSON.parse(unescape($.cookie("flash")));
  if(!data) data = {};
  Flash.data = data;
  $.removeCookie('flash', {path: '/', domain: document.domain});
};

Flash.writeDataTo = function(name, element, callback) {
  element = $(element);
  var message = "";
  if (Flash.data[name]) {
    message = Flash.data[name].toString().replace(/\+/g, ' ');
    element.html(message);
    if (callback && typeof(callback) === 'function') {
      callback(element);
    } else {
      element.show();
    }
  }
};
