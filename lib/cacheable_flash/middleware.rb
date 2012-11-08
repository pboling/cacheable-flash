module CacheableFlash
  class Middleware
    require 'cacheable_flash/cookie_flash'
    include CacheableFlash::CookieFlash
    FLASH_HASH_KEY = "action_dispatch.request.flash_hash".freeze

    def initialize(app)
      @app = app
    end

    # Cookies stick in the flash until rendered (cleared out of the cookie by javascript),
    #   to ensure they are seen and not lost, so we grab them from the rails flash hash, or the request cookies
    def call(env)
      status, headers, body = @app.call(env)
      env_flash = env[FLASH_HASH_KEY]

      if env_flash
        # There is a flash set from this request, merge it into the cookie flash (which may already be populated)
        cookies = Rack::Request.new(env).cookies
        Rack::Utils.set_cookie_header!(headers, "flash", :value => cookie_flash(flash, cookies), :path => "/")
      else
        # There is no flash set in this request but there are leftovers from previous requests still in the cookie
        request = ActionDispatch::Request.new(env)
        cflash = request.respond_to?(:cookie_jar) ?
          request.cookie_jar['flash'] :
          nil
        if cflash
          Rack::Utils.set_cookie_header!(headers, "flash", :value => cflash, :path => "/")
        end
      end
      [status, headers, body]
    end

  end
end
