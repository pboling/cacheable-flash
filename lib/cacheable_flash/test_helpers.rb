module CacheableFlash
  module TestHelpers
    def flash_cookie
      return {} unless cookies['flash']
      JSON.parse(cookies['flash'])
        rescue JSON::ParserError
      {}
    end
  end
end
