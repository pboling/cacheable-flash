require 'json'

module CacheableFlash
  if defined?(Rails) && ::Rails::VERSION::MAJOR == 3
    require 'cacheable_flash/middleware'
    require 'cacheable_flash/engine' if ::Rails::VERSION::MINOR >= 1
    require 'cacheable_flash/railtie'
  else 
    # For older rails use generator
  end

  require 'cacheable_flash/cookie_flash'
  include CookieFlash

  def self.included(base)
    #base must define around_filter, as in Rails
    base.around_filter :write_flash_to_cookie
  end

  def write_flash_to_cookie
    yield if block_given?

    # Base must define cookies, as in Rails
    cookies['flash'] = cookie_flash(flash, cookies)
    # Base must define flash, as in Rails
    # TODO: Does not support flash.now feature of the FlashHash in Rails, 
    #       because flashes are only removed from cookies when they are used.
    flash.clear
  end
end
