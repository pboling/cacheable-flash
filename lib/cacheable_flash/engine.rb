module CacheableFlash
  class Engine < ::Rails::Engine
    # Allow for Rails versions ~> 3.1 and > 3
    if (::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MAJOR >= 1) || ::Rails.VERSION::MAJOR > 3
      isolate_namespace CacheableFlash
    end
  end
end
