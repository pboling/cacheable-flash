// refactoring from https://github.com/leonid-shevtsov/cacheable-flash-jquery
var Flash = new Object();

Flash.data = {};

Flash.transferFromCookies = function() {
  var data = JSON.parse(unescape($.cookie("flash")));
  if(!data) data = {};
  Flash.data = data;
  $.cookie('flash',null, {path: '/'});
};

Flash.writeDataTo = function(name, element) {
  element = $(element);
  var content = "";
  if (Flash.data[name]) {
    message = Flash.data[name].toString().replace(/\+/g, ' ');
    element.html(message);
    element.show();
  }
};
