var Flash = new Object();

Flash.data = {};

Flash.transferFromCookies = function() {
  var data = JSON.parse(unescape((Cookie.get("flash") || '').replace(/\+/g, '%20')));
  if(!data) data = {};
  Flash.data = data;
  Cookie.erase("flash");
};

Flash.writeDataTo = function(name, element) {
  var content = "";
  if(Flash.data[name]) {
    content = Flash.data[name].toString().replace(/\+/g, ' ');
  }
  element.innerHTML = unescape(content);
};
