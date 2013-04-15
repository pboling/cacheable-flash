# encoding: utf-8

module CacheableFlash
  # Copies javascript libraries flash.js and jquery.cookie.js to public/javascripts/ (Rails 3.0.X only, Rails 3.1 has asset pipeline)
  #
  # @example
  #   $ rails generate cacheable_flash:install
  #
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../../vendor/assets/javascripts/', __FILE__)
    desc "Copies some JS files to public/javascripts/"
    def copy_files
      template 'flash.js',     'public/javascripts/flash.js'
      template 'jquery.cookie.js', 'public/javascripts/jquery.cookie.js'
    end
  end
end
