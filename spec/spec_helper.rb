#TODO: Specs will need a 'test' rails app to run within, or to mock things like ::Rails.root

require 'rspec'
require "json"
require "active_support"
require "action_controller"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'cacheable_flash'
require "support/test_helpers"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end
