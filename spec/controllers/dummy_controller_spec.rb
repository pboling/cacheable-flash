require 'spec_helper'

describe DummyController do
  describe 'cacheable_flash works' do
    render_views
    before(:each) do
      get :index
    end
    it "should assign flash" do
      expected_flash = {
        'errors' => "This is an Error",
        'notice' => "This is a Notice"
      }
      flash[:errors].should == expected_flash['errors']
      flash[:notice].should == expected_flash['notice']
    end
  end
end

