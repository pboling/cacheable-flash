module CacheableFlash
  class Middleware
    require 'cacheable_flash/cookie_flash'
    include CookieFlash
    FLASH_HASH_KEY = "action_dispatch.request.flash_hash".freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      flash = env[FLASH_HASH_KEY]

      if flash
        response = Rack::Response.new(body, status, headers)

        cookies = env["rack.cookies"] || {}
        response.set_cookie("flash", { :value => cookie_flash(flash, cookies), :path => "/" })
        response.finish
      else
        [status, headers, body]
      end
    end
  end
end
