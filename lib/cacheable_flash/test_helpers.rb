require 'json'

module CacheableFlash
  module TestHelpers

    def flash_cookie
      return {} unless response.cookies['flash']
      JSON(response.cookies['flash'])
    rescue JSON::ParserError
      {}
    end

  end
end
