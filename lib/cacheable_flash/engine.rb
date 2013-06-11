module CacheableFlash
  class Engine < ::Rails::Engine
    # Allow for Rails versions ~> 3.1 and > 3
    if (::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR >= 1) || ::Rails::VERSION::MAJOR > 3
      isolate_namespace CacheableFlash
    else
      warn 'CacheableFlash namespace not isolated, check that Rails version is >= 3.1'
    end
  end
end
