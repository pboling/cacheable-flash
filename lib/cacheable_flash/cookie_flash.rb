module CacheableFlash
  module CookieFlash
    def cookie_flash(flash, cookies)
      cookie_flash = (JSON(cookies['flash']) if cookies['flash']) || {} rescue {}

      flash.each do |key, value|
        value = ERB::Util.html_escape(value) unless value.is_a?(Hash) || value.html_safe?
        if cookie_flash[key.to_s].blank?
          value_as_string = value.kind_of?(Numeric) ? value.to_s : value
          case CacheableFlash::Config[:append_as]
            when :br then
              cookie_flash[key.to_s] = value_as_string
            when :array then
              cookie_flash[key.to_s] = Array(value_as_string)
            else
              raise "CacheableFlash: #{CacheableFlash::Config.config[:append_as]} is not a valid value for CacheableFlash::Config.config[:append_as]"
          end
        else
          case CacheableFlash::Config[:append_as]
            when :br then
              cookie_flash[key.to_s] << "<br/>#{value}"
            when :array then
              cookie_flash[key.to_s] << "#{value}"
            else
              raise "CacheableFlash: #{CacheableFlash::Config.config[:append_as]} is not a valid value for CacheableFlash::Config.config[:append_as]"
          end
        end
      end
      cookie_flash.to_json.gsub("+", "%2B")
    end
  end
end
