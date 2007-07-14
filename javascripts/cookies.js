var Cookies = new Object();

Cookies.read = function(name) {
  var nameEQ = name + "=";
  var cookies = document.cookie.split(';');
  var matches = [];
  for(var i=0;i < cookies.length;i++) {
    var cookie = cookies[i];
    while (cookie.charAt(0)==' ') {
      cookie = cookie.substring(1, cookie.length);
    }
    if (cookie.indexOf(nameEQ) == 0) {
      matches.push(cookie.substring(nameEQ.length, cookie.length));
    }
  }
  return matches.last() || null;
}

Cookies.write = function(name, value) {
  var expires = new Date();
  expires.setYear(expires.getFullYear() + 1);
  var expiresText = " expires=" + expires.toGMTString();
  document.cookie = escape(name) + "=" + escape(value) + "; path=/;" + expiresText;
}

Cookies.expire = function(name) {
  var expirationDate = new Date();
  expirationDate.setTime(expirationDate.getTime() - 1);
  document.cookie = escape(name) + "=null; path=/; expires=" + expirationDate.toGMTString() + ";";
}

Cookies.expireAll = function() {
  // Get cookie string and separate into individual cookie phrases:
  var cookieString = "" + document.cookie;
  var cookieArray = cookieString.split("; ");

  // Try to delete each cookie:
  for(var i = 0; i < cookieArray.length; ++ i)
  {
    var singleCookie = cookieArray[i].split("=");
    if(singleCookie.length != 2)
      continue;
    var name = unescape(singleCookie[0]);
    Cookies.expire(name);
  }
}
