module CacheableFlash
  class Config

    class << self
      attr_accessor :config
    end

    DEFAULTS = {
      :stacking => false, # or true if you want auto-magically stacking flashes
      # Specify how multiple flashes at the same key (e.g. :notice, :errors) should be handled
      # :append_as is ignored if :stacking is false
      :append_as => :br, # or :array, :p, :ul, :ol, or a proc or lambda of your own design
      # if domain is unspecified, defaults to nil and the request domain is used (see middleware.rb)
      :domain => nil
    }

    @config ||= DEFAULTS
    def self.configure &block
      yield @config
      if @config[:stacking]
        StackableFlash.stacking = true
        StackableFlash::Config.configure do |config|
          # by default behave like regular non-stacking flash
          if @config[:append_as].respond_to?(:call)
            config[:stack_with_proc] = @config[:append_as]
          else
            config[:stack_with_proc] = case @config[:append_as]
              # Escape as many strings as we can!
              when :br then Proc.new {|arr| arr.map { |x| x.kind_of?(String) && !x.html_safe? ? ERB::Util.html_escape(x) : x }.join('<br/>') }
              when :array then Proc.new {|arr| arr.map { |x| x.kind_of?(String) && !x.html_safe? ? ERB::Util.html_escape(x) : x } }
              when :p then Proc.new {|arr| arr.map! {|x| "<p>#{x.kind_of?(String) && !x.html_safe? ? ERB::Util.html_escape(x) : x }</p>"}.join }
              when :ul then Proc.new {|arr| '<ul>' + arr.map! {|x| "<li>#{x.kind_of?(String) && !x.html_safe? ? ERB::Util.html_escape(x) : x }</li>"}.join + '</ul>' }
              when :ol then Proc.new {|arr| '<ol>' + arr.map! {|x| "<li>#{x.kind_of?(String) && !x.html_safe? ? ERB::Util.html_escape(x) : x }</li>"}.join + '</ol>' }
              else Proc.new {|arr| arr.map { |x| x.kind_of?(String) && !x.html_safe? ? ERB::Util.html_escape(x) : x }.join('<br/>') }
            end
          end
        end
      else
        StackableFlash.stacking = false
      end
    end

  end
end
