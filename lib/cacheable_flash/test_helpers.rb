require 'json'
require 'stackable_flash/test_helpers'   # Used in the definition of the rspec matchers, and also useful to Test::Unit

module CacheableFlash
  module TestHelpers

    include StackableFlash::TestHelpers # provides *flash_in_stack* method

    def flash_cookie
      return {} unless cooked_flash = response.cookies['flash']
      JSON(cooked_flash)
    rescue JSON::ParserError
      {}
    end

    def flash_cookie_for(response)
      return {} unless cooked_flash = response.cookies['flash']
      JSON(cooked_flash)
    rescue JSON::ParserError
      {}
    end

  end
end
