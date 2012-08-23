require 'spec_helper'

describe DummyController do
  before(:each) do
    CacheableFlash::Config.configure do |config|
      config[:stacking] = true
      config[:append_as] = :array
    end
  end
  after(:each) do
    StackableFlash.stacking = false
  end

  describe "cookie flash is sticky" do
    it "should not clear after request" do # because they are only cleared out by javascripts
      get "/dummy/index"
      response.should have_flash_cookie('errors', "This is an Error")
      response.should have_flash_cookie('notice', "This is a Notice")

      get "/dummy/no_flash"
      response.should have_flash_cookie('errors', "This is an Error")
      response.should have_flash_cookie('notice', "This is a Notice")

    end
  end

  describe "cookie flash is stackable" do
    it "should not overwrite when new flash added" do # because they are only cleared out by javascripts
      get "/dummy/index"
      response.should have_flash_cookie('errors', "This is an Error")
      response.should have_flash_cookie('notice', "This is a Notice")

      get "/dummy/error?id=1"
      response.should have_flash_cookie('errors', "This is an Error")
      response.should have_flash_cookie('errors', "Error #1")

      get "/dummy/error?id=2"
      response.should have_flash_cookie('errors', "This is an Error")
      response.should have_flash_cookie('errors', "Error #1")
      response.should have_flash_cookie('errors', "Error #2")
    end
  end

  # Stolen (and converted to a request spec) from stackable_flash:
  #   https://github.com/pboling/stackable_flash/blob/master/spec/controllers/dummy_controller_spec.rb
  it "should handle multiple keys" do
    get "/dummy/multiple_keys"
    response.should have_flash_cookie('notice', 'This is a Notice')
    response.should have_flash_cookie('errors', 'This is an Error')
  end

  it "should override" do
    get "/dummy/override"
    response.should_not have_flash_cookie('notice','original')
    response.should have_flash_cookie('notice','message')
  end

  it "should stack" do
    get "/dummy/stack"
    response.should have_flash_cookie('notice',['original','message','another'])
  end

  it "should cold boot" do
    get "/dummy/cold_boot"
    response.should have_flash_cookie('notice',['original','message','another'])
  end

  it "should allow use of have_cacheable_flash matcher" do
    get "/dummy/cold_boot"
    lambda {response.should have_cacheable_flash('notice',['original','message','another'])}.should_not raise_exception
  end

end
