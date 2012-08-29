# encoding: utf-8

module CacheableFlash
  # Copies javascript libraries flash.js and jquery.cookie.js to public/javascripts/ (Rails 3.0.X only, Rails 3.1 has asset pipeline)
  #
  # @example
  #   $ rails generate cacheable_flash:install
  #
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../vendor/assets/javascripts/', __FILE__)

    # Rails 3.1 has the asset pipeline, no need to copy javascript files anymore
    # Rails 3.0 doesn't have an asset pipeline, so we copy in javascript files
    desc "Copies some JS files to public/javascripts/"
    def copy_files
      # Also raose this deprecation in rails 4
      if (::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR == 1) || ::Rails::VERSION::MAJOR > 3
        ActiveSupport::Deprecation.warn("Rails 3.1 has the asset pipeline, so you only need to copy javascript files if you aren't using it.")
      end
      template 'flash.js',     'public/javascripts/flash.js'
      template 'jquery.cookie.js', 'public/javascripts/jquery.cookie.js'
    end
  end
end
