require 'json'

module CacheableFlash
  module TestHelpers
    def flash_cookie
      return {} unless response.cookies['flash']
      JSON(response.cookies['flash'])
    rescue JSON::ParserError
      {}
    end
    
    module Rspec
      RSpec::Matchers.define :have_flash_cookie do |flash_status, regex|
        define_method :has_flash_cookie? do |response|
          regex = /^#{Regexp.escape(regex)}$/ if regex.is_a?(String)
  
          cook = begin
            response.cookies['flash'] ?
              JSON(response.cookies['flash']) :
              {}
          rescue JSON::ParserError
            {}
          end
          cook[flash_status] =~ regex
        end
        match{|response| has_flash_cookie?(response)}
      end
    end
  end
end
