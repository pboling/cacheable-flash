module CacheableFlash
  require 'rails'
  if ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR == 0
    require 'cacheable_flash/rails/railtie'
  elsif ::Rails.version >= "3.1"
    require 'cacheable_flash/rails/engine'
    require 'cacheable_flash/rails/railtie'
  else
    # For older rails use generator
  end

  def self.included(base)
    base.around_filter :write_flash_to_cookie
  end

  def write_flash_to_cookie
    yield if block_given?
    cookie_flash = if cookies['flash']
      begin
        ActiveSupport::JSON.decode(cookies['flash'])
      rescue
        {}
      end
    else
      {}
    end

    flash.each do |key, value|
      if cookie_flash[key.to_s].blank?
        cookie_flash[key.to_s] = value.kind_of?(Numeric) ? value.to_s : value
      else
        cookie_flash[key.to_s] << "<br/>#{value}"
      end
    end

    cookies['flash'] = cookie_flash.to_json.gsub("+", "%2B")
    flash.clear
  end
end
