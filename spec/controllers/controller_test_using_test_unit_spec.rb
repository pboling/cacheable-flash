require "test/unit"
require "rails/test_help"
require "cacheable_flash/test_helpers"

class TestController < ActionController::Base
  include CacheableFlash
  
  def index
    flash["notice"] = "In index"
    render :text => "WORKING!!!"
  end
end

class ControllerTest < ActionController::TestCase
  include CacheableFlash::TestHelpers

  def setup
    @controller = TestController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  def test_cacheable_flash_action
    get :index
    assert_equal "In index", flash_cookie["notice"]
  end
end

