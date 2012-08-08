require 'spec_helper'

describe DummyController do

  include CacheableFlash::TestHelpers

  render_views

  before(:each) do
    @expected_flash = {
      'errors' => "This is an Error",
      'notice' => "This is a Notice"
    }
    get :index
  end

  describe "TestHelpers" do
    it "should assign flashes to cookie" do
      flash_cookie['errors'].should == @expected_flash['errors']
      flash_cookie['notice'].should == @expected_flash['notice']
      flash_cookie.should == @expected_flash
    end
  end

end

