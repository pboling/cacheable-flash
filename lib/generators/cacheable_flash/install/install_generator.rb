# encoding: utf-8

module CacheableFlash
  # Copies javascript libraries flash.js and jquery.cookie.js to public/javascripts/ (Rails 3.0.X only, Rails 3.1 has asset pipeline)
  #
  # @example
  #   $ rails generate cacheable_flash:install
  #
  # @todo Test with Rails 3.0
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../templates', __FILE__)
    class_option :template_engine

    if ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR >= 1
      # Rails 3.1 has the asset pipeline, no need to copy CSS files any more
    else
      # Rails 3.0 doesn't have an asset pipeline, so we copy in javascript files
      desc "Copies some JS files to public/javascripts/"
      def copy_files
        template '../../../app/assets/stylesheets/formtastic.css',     'public/stylesheets/formtastic.css'
        template '../../../app/assets/stylesheets/formtastic_ie6.css', 'public/stylesheets/formtastic_ie6.css'
        template '../../../app/assets/stylesheets/formtastic_ie7.css', 'public/stylesheets/formtastic_ie7.css'
      end
    end

    def copy_scaffold_template
      engine = options[:template_engine]
      copy_file "_form.html.#{engine}", "lib/templates/#{engine}/scaffold/_form.html.#{engine}"
    end
  end
end
