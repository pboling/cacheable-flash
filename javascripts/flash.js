var Flash = new Object();

Flash.data = {};

Flash.json_parse = function (text)
{
    try
    {
        return !(/[^,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]/.test(text.replace(/"(\\.|[^"\\])*"/g, '')))
               && eval('(' + text + ')');
    } catch (e) {
        return false;
    }
};

Flash.transferFromCookies = function()
{
  var json = $.cookie("flash").replace(/\+/g, " ").replace(/%2B/g, "+");
  var data = Flash.json_parse(json);
  if (!data) data = {};
  Flash.data = data;
  $.cookie("flash", null); // remove cookie
};

Flash.writeDataTo = function(name, element)
{
  element = $(element);
  var content = "";
  if(Flash.data[name]) {
    content = Flash.data[name].toString();
  }
  element.html(unescape(content));
};
