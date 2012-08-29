module CacheableFlash
  class Engine < ::Rails::Engine
    if ::Rails::VERSION::MAJOR > 3 || ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MAJOR >= 1
      isolate_namespace CacheableFlash
    end
  end
end
