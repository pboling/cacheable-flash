module CacheableFlash
  class Config

    class << self
      attr_accessor :config
    end

    DEFAULTS = {
      # Specify how multiple flashes at the same key (e.g. :notice, :errors) should be handled
      :append_as => :br, # or :array, :p, :ul, :ol, or a proc or lambda of your own design
    }

    self.config ||= DEFAULTS
    def self.configure &block
      yield @@config
      StackableFlash::Config.configure do
        if self.config[:append_as].respond_to?(:call)
          config[:stack_with_proc] = self.config[:append_as]
        else
          config[:stack_with_proc] = case self.config[:append_as]
            when :br then Proc.new {|arr| arr.join('<br/>') }
            when :array then Proc.new {|arr| arr }
            when :p then Proc.new {|arr| arr.map! {|x| "<p>#{x}</p>"}.join }
            when :ul then Proc.new {|arr| '<ul>' + arr.map! {|x| "<li>#{x}</li>"}.join + '</ul>' }
            when :ol then Proc.new {|arr| '<ol>' + arr.map! {|x| "<li>#{x}</li>"}.join + '</ol>' }
          end
        end
      end
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
