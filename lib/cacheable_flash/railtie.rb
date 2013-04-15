# Add cacheable flash JS to defaults for Rails < 3.1 (not needed with asset pipeline)
module CacheableFlash
  class Railtie < ::Rails::Railtie
    config.before_configuration do
      config.action_view.javascript_expansions[:cacheable_flash] = %w(jquery.cookie flash)
    end
  end
end
