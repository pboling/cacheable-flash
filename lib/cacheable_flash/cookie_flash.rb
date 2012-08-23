module CacheableFlash
  module CookieFlash

    # @parameters
    #   cookies -
    #     There might be crusty flash from a previous request, or set elsewhere, already in the cookie.
    #     Pull it out and parse it so we can preserve it.
    #   flash -
    #     This is the fresh, super-stacked (by stackable_flash gem) FlashHash from the current request.
    #     Needs to be added to the cookie flash.
    def cookie_flash(flash, cookies)
      cflash = (JSON.parse(cookies['flash']) if cookies['flash']) || {} rescue {}

      flash.each do |key, value| # key like :notice, or :error, or :sticky
        # When stacking we won't be escaping anything here, because will be array, not string
        value = ERB::Util.html_escape(value) if value.kind_of?(String) && !value.html_safe? # Since v0.3.0 only escaping strings
        skey = key.to_s
        # This allows any data type to be stored in the cookie; important for using an array as the value with
        # stackable_flash
        # The cookie flash will generally be set to a value stacked according to the :stack_with_proc of stackable_flash
        # But when there is already a value for the cookie when we get here, we need to join them somehow.
        stacked_value = value.respond_to?(:stack) ? value.stack : value
        if cflash[skey].kind_of?(Array) # Just because it could be an array
          if stacked_value.kind_of?(Array)
            cflash[skey] += stacked_value
          else
            cflash[skey] << stacked_value
          end
        else
          cflash[skey] = stacked_value
        end
      end
      # I have forgotten why the gsub + matters, so NOTE: to future self: document weird shit.
      cflash.to_json.gsub("+", "%2B")
    end
  end
end
