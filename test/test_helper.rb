require "rubygems"
require "test/unit"
require "json"
require "rr"
require "tmpdir"
require "fileutils"
require "active_support"

dir = File.dirname(__FILE__)
$LOAD_PATH << "#{dir}/../lib"
require "cacheable_flash"

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end