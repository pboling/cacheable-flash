module CacheableFlash
  def self.included(base)
    base.after_filter :write_flash_to_cookie
  end

  def write_flash_to_cookie
    cookies['flash'] = flash.to_json
  end
end
