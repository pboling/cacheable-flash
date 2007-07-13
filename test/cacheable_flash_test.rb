dir = File.dirname(__FILE__)
require "#{dir}/test_helper"

class CacheableFlashTest < Test::Unit::TestCase
  def setup
    @controller_class = Struct.new(:cookies, :flash)
    @controller_class.stubs(:after_filter)
    @controller_class.send(:include, CacheableFlash)
    @controller = @controller_class.new({}, {})
  end
  
  def test_write_flash_to_cookie
    expected_flash = {
      'errors' => "This is an Error",
      'notice' => "This is a Notice"
    }
    @controller.flash = expected_flash
    @controller.write_flash_to_cookie

    assert_equal expected_flash, JSON.parse(@controller.cookies['flash'])
  end
end

class CacheableFlashAfterFilterTest < Test::Unit::TestCase
  def test_after_filter_is_set
    @controller_class = Struct.new(:cookies, :flash)
    @controller_class.expects(:after_filter).with(:write_flash_to_cookie)
    @controller_class.send(:include, CacheableFlash)
  end
end