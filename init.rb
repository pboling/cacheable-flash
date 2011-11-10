require "json"
require "cacheable_flash"
#use Rails::VERSION::STRING for rails < 1 somehow -- or perhaps, who cares??
if ::Rails::VERSION::MAJOR == 2
  ActionView::Helpers::AssetTagHelper.register_javascript_include_default('jquery.cookie','flash')
end
