module CacheableFlash
  module TestHelpers
    def flash_cookie
      return {} unless cookies['flash']
      JSON.parse(cookies['flash'].first)
    end    
  end
end