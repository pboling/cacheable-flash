require 'spec_helper'

describe DummyController do

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

      get "/dummy/error"
      response.should have_flash_cookie('errors', "This is an Error")
      response.should have_flash_cookie('errors', "This is a real Error")

    end
  end

end
