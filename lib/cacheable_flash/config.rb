require 'facets/module/mattr' # gives cattr

module CacheableFlash
  class Config

    DEFAULTS = {
      # Specify how multiple flashes at the same key (e.g. :notice, :errors) should be handled
      :append_as => :br, # or :array
    }

    cattr_reader :config
    cattr_writer :config

    self.config ||= DEFAULTS
    def self.configure &block
      yield @@config
    end

    def self.[](key)
      return nil unless key.respond_to?(:to_sym)
      CacheableFlash::Config.config[key.to_sym]
    end

    def self.method_missing(name, *args)
      CacheableFlash[name]
    end

  end
end
