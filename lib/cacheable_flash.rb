require 'json'

module CacheableFlash
  if defined?(Rails) && ::Rails::VERSION::MAJOR == 3
    if ::Rails::VERSION::MINOR >= 1
      require "cacheable_flash/engine"
      require 'cacheable_flash/railtie'
    elsif ::Rails::VERSION::MINOR == 0
      require 'cacheable_flash/railtie'
    end
  else
    # For older rails use generator
  end

  def self.included(base)
    #base must define around_filter, as in Rails
    base.around_filter :write_flash_to_cookie
  end

  def write_flash_to_cookie
    yield if block_given?
    cookie_flash = if cookies['flash']
      begin
        JSON(cookies['flash'])
      rescue
        {}
      end
    else
      {}
    end

    flash.each do |key, value|
      if cookie_flash[key.to_s].blank?
        cookie_flash[key.to_s] = value.to_s
      else
        cookie_flash[key.to_s] << "<br/>#{value}"
      end
    end
    # Base must define cookies, as in Rails
    cookies['flash'] = cookie_flash.to_json.gsub("+", "%2B")
    # Base must define flash, as in Rails
    # TODO: Does not support flash.now feature of the FlashHash in Rails, 
    #       because flashes are only removed from cookies when they are used.
    flash.clear
  end
end
