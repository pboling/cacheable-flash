module CacheableFlash
  module CookieFlash
    def cookie_flash(flash, cookies)
      cflash = (JSON.parse(cookies['flash']) if cookies['flash']) || {} rescue {}
      flash.each do |key, value|
        # Since v0.3.0 only escaping strings
        if value.kind_of?(String)
          value = ERB::Util.html_escape(value) unless value.html_safe?
        end
        skey = key.to_s
        # This allows any data type to be stored in the cookie; important for using an array as the value with
        # stackable_flash
        if cflash[skey].kind_of?(Array) # Already Stackable!!!
          if value.kind_of?(Array)
            cflash[skey] += value # Add the values from the other array, which is already a stackable flash
          else
            cflash[skey] << value
          end
        else
          cflash[skey] = value
        end
      end
      # I have forgotten why the gsub + matters, so NOTE: to future self: document weird shit.
      cflash.to_json.gsub("+", "%2B")
    end
  end
end
