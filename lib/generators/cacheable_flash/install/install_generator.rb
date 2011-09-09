# encoding: utf-8

module CacheableFlash
  # Copies javascript libraries flash.js and jquery.cookie.js to public/javascripts/ (Rails 3.0.X only, Rails 3.1 has asset pipeline)
  #
  # @example
  #   $ rails generate cacheable_flash:install
  #
  # @todo Test with Rails 3.0
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../vendor/assets/javascripts', __FILE__)
    class_option :template_engine

    # Rails 3.1 has the asset pipeline, no need to copy javascript files anymore
    # Rails 3.0 doesn't have an asset pipeline, so we copy in javascript files
    if ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR == 0
      desc "Copies some JS files to public/javascripts/"
      def copy_files
        template 'flash.js',     'public/javascripts/flash.js'
        template 'jquery.cookie.js', 'public/javascripts/jquery.cookie.js'
      end
    end
  end
end
