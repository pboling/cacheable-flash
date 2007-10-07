require "rubygems"
require "test/unit"
require "json"
require "rr"
require "tmpdir"
require "fileutils"
require "active_support"
require "action_controller"
require "action_controller/test_process"

dir = File.dirname(__FILE__)
$LOAD_PATH << "#{dir}/../lib"
require "cacheable_flash"
require "cacheable_flash/test_helpers"

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end