module CacheableFlash
  class Middleware
    require 'cacheable_flash/cookie_flash'
    include CacheableFlash::CookieFlash
    FLASH_HASH_KEY = "action_dispatch.request.flash_hash".freeze

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      env_flash = env[FLASH_HASH_KEY]

      if env_flash
        cookies = Rack::Request.new(env).cookies
        Rack::Utils.set_cookie_header!(headers, "flash", :value => cookie_flash(env_flash, cookies), :path => "/")
      end
      [status, headers, body]
    end

  end
end
