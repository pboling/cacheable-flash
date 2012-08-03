module CookieFlash
  def cookie_flash(flash, cookies)
    cookie_flash = (JSON(cookies['flash']) if cookies['flash']) || {} rescue {}

    flash.each do |key, value|
      value = ERB::Util.html_escape(value) unless value.is_a?(Hash) || value.html_safe?
      if cookie_flash[key.to_s].blank?
        cookie_flash[key.to_s] = value.kind_of?(Numeric) ? value.to_s : value
      else
        cookie_flash[key.to_s] << "<br/>#{value}"
      end
    end
    cookie_flash.to_json.gsub("+", "%2B")
  end
end
