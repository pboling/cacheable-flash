gem "json", ">=1.1.2"
require "json"
require "cacheable_flash"
ActionView::Helpers::AssetTagHelper.register_javascript_include_default('cookie','flash','json')
