module CacheableFlash
  class Engine < ::Rails::Engine
    if ::Rails::VERSION::MAJOR > 3 || ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MAJOR >= 1
      isolate_namespace CacheableFlash
    else
      warn 'CacheableFlash namespace not isolated, check that Rails version is >= 3.1'
    end
  end
end
