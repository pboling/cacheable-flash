require 'json'

module CacheableFlash
  module TestHelpers

    def flash_cookie
      return {} unless cooked_flash = response.cookies['flash']
      JSON(cooked_flash)
    rescue JSON::ParserError
      {}
    end

    def testable_flash(response)
      return {} unless cooked_flash = response.cookies['flash']
      JSON(cooked_flash)
    rescue JSON::ParserError
      {}
    end

  end
end
