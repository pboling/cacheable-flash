module CacheableFlash
  module TestHelpers
    def flash_cookie
      return {} unless cookies['flash']
      ActiveSupport::JSON.decode(cookies['flash'])
    rescue JSON::ParserError
      {}
    end
  end
end
