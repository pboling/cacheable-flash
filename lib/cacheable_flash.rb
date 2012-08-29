require 'json'
require 'stackable_flash'

module CacheableFlash
  if defined?(Rails) && (::Rails::VERSION::MAJOR == 3 || ::Rails.VERSION::MAJOR > 3)
    require 'cacheable_flash/middleware'

    # Since rails 3.0 doesn't have engine support
    if ::Rails::VERSION::MAJOR > 3 || ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MAJOR >= 1
      require 'cacheable_flash/engine'
    end

    require 'cacheable_flash/railtie'
  else
    # For older rails use generator
  end

  # By default stacking is false, but it can be turned on with:
  # CacheableFlash.configure do |config|
  #   config[:stacking] = true
  #   config[:append_as] = :br # Pick a value, set your own proc, or don't: passes the JSON'd array to the cookie
  # end
  StackableFlash.stacking = false

  # The configure will override the above default
  require 'cacheable_flash/config'
  require 'cacheable_flash/cookie_flash'
  include CacheableFlash::CookieFlash

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

  # simply abstracts the StackableFlash.stacking method
  def self.stacking
    StackableFlash.stacking
  end
end
