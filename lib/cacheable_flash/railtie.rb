# Add cacheable flash JS to defaults for Rails < 3.1 (not needed with asset pipeline
module Jquery
  module Rails

    class Railtie < ::Rails::Railtie
      if ::Rails::VERSION::MAJOR == 3
        config.before_configuration do
          config.action_view.javascript_expansions[:defaults] |= %w(flash jquery.cookie)
        end
      end
    end

  end
end
