dir = File.dirname(__FILE__)
require File.expand_path("#{dir}/../spec_helper")

class TestHelpersTest < Test::Unit::TestCase
  include CacheableFlash::TestHelpers
  
  def setup
    @controller = ActionController::Base.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @controller.send(:initialize_template_class, @response)
    @controller.send(:assign_shortcuts, @request, @response)
    
    @flash = @controller.send(:flash)
    class << @controller
      include CacheableFlash
    end
  end
  
  def test_flash_cookie__returns_the_flash_hash_in_cookies
    expected_flash = {
      'errors' => "This is an Error",
      'notice' => "This is a Notice"
    }
    @flash['errors'] = expected_flash['errors']
    @flash['notice'] = expected_flash['notice']
    @controller.write_flash_to_cookie

    assert_equal expected_flash, flash_cookie
  end

  def cookies
    @response.cookies
  end
end