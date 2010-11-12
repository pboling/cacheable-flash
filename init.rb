if config.respond_to?(:gems)
  config.gem 'json', :version => ">=1.1.2"
else
  begin
    gem "json", ">=1.1.2"
  rescue Gem::LoadError
    puts "Install the json gem, version >= 1.1.2"
  end
end

require "json"
require "cacheable_flash"
ActionView::Helpers::AssetTagHelper.register_javascript_include_default('jquery.cookie','flash')
