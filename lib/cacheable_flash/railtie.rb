module CacheableFlash
  class Railtie < ::Rails::Railtie
    # Add cacheable flash JS to defaults for Rails < 3.1 (not needed with asset pipeline)
    if ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR == 0
      config.before_configuration do
        config.action_view.javascript_expansions[:cacheable_flash] = %w(js.cookie flash)
      end
    end
  end
end
