var Flash = new Object();

Flash.data = {};

Flash.transferFromCookies = function() {
  var json = Cookie.get("flash").replace(/\+/g, " ").replace(/%2B/g, "+");
  var data = JSON.parse(json);
  if(!data) data = {};
  Flash.data = data;
  Cookie.erase("flash");
};

Flash.writeDataTo = function(name, element) {
  element = $(element);
  var content = "";
  if(Flash.data[name]) {
    content = Flash.data[name].toString();
  }
  element.html(unescape(content));
};
