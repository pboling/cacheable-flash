dir = File.dirname(__FILE__)
require "#{dir}/../test_helper"

class CacheableFlashTest < Test::Unit::TestCase
  def setup
    @controller_class = Struct.new(:cookies, :flash)
    stub(@controller_class).after_filter
    @controller_class.send(:include, CacheableFlash)
    @controller = @controller_class.new({}, {})
    @cookies = {}
    stub(@controller).cookies {@cookies}
  end
  
  def test_write_flash_to_cookie
    expected_flash = {
      'errors' => "This is an Error",
      'notice' => "This is a Notice"
    }
    @controller.flash = expected_flash.dup
    @controller.write_flash_to_cookie

    assert_equal expected_flash, JSON.parse(@controller.cookies['flash'])
  end

  def test_flash_is_appended_to_existing_flash_cookie
    @cookies['flash'] = {
      'notice' => "Existing notice",
      'errors' => "Existing errors",
    }.to_json

    @controller.flash = {
      'notice' => 'New notice',
      'errors' => 'New errors',
    }

    @controller.write_flash_to_cookie

    expected_flash = {
      'notice' => "Existing notice<br/>New notice",
      'errors' => "Existing errors<br/>New errors",
    }
    assert_equal expected_flash, JSON.parse(@controller.cookies['flash'])
  end

  def test_flash_is_cleared
    flash = {
      'errors' => "This is an Error",
      'notice' => "This is a Notice"
    }
    @controller.flash = flash
    @controller.write_flash_to_cookie

    assert_equal({}, @controller.flash)
  end
end

class CacheableFlashAfterFilterTest < Test::Unit::TestCase
  def test_after_filter_is_set
    @controller_class = Struct.new(:cookies, :flash)
    mock(@controller_class).after_filter(:write_flash_to_cookie)
    @controller_class.send(:include, CacheableFlash)
  end
end