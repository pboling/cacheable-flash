require 'spec_helper'

describe DummyController do

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
      response.should have_flash_cookie('errors', @expected_flash['errors'])
      response.should have_flash_cookie('notice', @expected_flash['notice'])
    end
  end

end

