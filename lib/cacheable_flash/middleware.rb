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
        response = Rack::Response.new(body, status, headers)
        cookies = env["rack.cookies"] || {}
        response.set_cookie("flash", { :value => cookie_flash(env_flash, cookies), :path => "/" })
        response.finish
      else
        # There is no flash set in this request but there are leftovers from previous requests still in the cookie
        request = ActionDispatch::Request.new(env)
        cflash = request.respond_to?(:cookie_jar) ?
          request.cookie_jar['flash'] :
          nil
        if cflash
          response = Rack::Response.new(body, status, headers)
          response.set_cookie("flash", { :value => cflash, :path => "/" })
          response.finish
        else
          response = body
        end
      end
      [status, headers, response]
    end

  end
end
