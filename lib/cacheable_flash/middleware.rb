module CacheableFlash
  class Middleware
    require 'cacheable_flash/cookie_flash'
    include CookieFlash
    FLASH_HASH_KEY = "action_dispatch.request.flash_hash".freeze

    def initialize(app)
      @app = app
    end

    # Cookies stick in the flash until rendered (cleared out of the cookie by javascript),
    #   to ensure they are seen and not lost, so we grab them from the rails flash hash, or the request cookies
    def call(env)
      status, headers, body = @app.call(env)
      flash = env[FLASH_HASH_KEY]

      request = ActionDispatch::Request.new(env)
      cookie_flash = request.respond_to?(:cookie_jar) ?
        request.cookie_jar['flash'] :
        nil

      if flash
        response = Rack::Response.new(body, status, headers)
        cookies = env["rack.cookies"] || {}
        response.set_cookie("flash", { :value => cookie_flash(flash, cookies), :path => "/" })
        response.finish
      elsif cookie_flash
        response = Rack::Response.new(body, status, headers)
        response.set_cookie("flash", { :value => cookie_flash, :path => "/" })
        response.finish
      else
        [status, headers, body]
      end
    end

  end
end
