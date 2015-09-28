require 'spec_helper'

describe DummyController, type: :request do
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
      expect(response).to have_flash_cookie('errors', "This is an Error")
      expect(response).to have_flash_cookie('notice', "This is a Notice")

      get "/dummy/no_flash"
      expect(response).to have_flash_cookie('errors', "This is an Error")
      expect(response).to have_flash_cookie('notice', "This is a Notice")

    end
  end

  describe "cookie flash is stackable" do
    it "should not overwrite when new flash added" do # because they are only cleared out by javascripts
      get "/dummy/index"
      expect(response).to have_flash_cookie('errors', "This is an Error")
      expect(response).to have_flash_cookie('notice', "This is a Notice")

      get "/dummy/error?id=1"
      expect(response).to have_flash_cookie('errors', "This is an Error")
      expect(response).to have_flash_cookie('errors', "Error #1")

      get "/dummy/error?id=2"
      expect(response).to have_flash_cookie('errors', "This is an Error")
      expect(response).to have_flash_cookie('errors', "Error #1")
      expect(response).to have_flash_cookie('errors', "Error #2")
    end
  end

  # Stolen (and converted to a request spec) from stackable_flash:
  #   https://github.com/pboling/stackable_flash/blob/master/spec/controllers/dummy_controller_spec.rb
  it "should handle multiple keys" do
    get "/dummy/multiple_keys"
    expect(response).to have_flash_cookie('notice', 'This is a Notice')
    expect(response).to have_flash_cookie('errors', 'This is an Error')
  end

  it "should override" do
    get "/dummy/override"
    expect(response).to_not have_flash_cookie('notice','original')
    expect(response).to have_flash_cookie('notice','message')
  end

  it "should stack" do
    get "/dummy/stack"
    expect(response).to have_flash_cookie('notice',['original','message','another'])
  end

  it "should cold boot" do
    get "/dummy/cold_boot"
    expect(response).to have_flash_cookie('notice',['original','message','another'])
  end

  it "should allow use of have_cacheable_flash matcher" do
    get "/dummy/cold_boot"
    expect {expect(response).to have_cacheable_flash('notice',['original','message','another'])}.to_not raise_exception
  end

end
