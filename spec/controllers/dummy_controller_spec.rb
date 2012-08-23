require 'spec_helper'

# Controller specs do not hit the full rails stack, and Middleware is ignored.
# For this reason testing in the controller must rely on the around filter,
# even if you are actually using the Middleware in your actual app
# The DummyController in the dummy app includes CacheableFlash to make the helpers testable as a controller spec.

describe DummyController do

  render_views

  describe "CacheableFlash::TestHelpers" do
    describe "#flash_cookie" do
      describe "not stacking" do
        # This is default, so, as long as other tests don't bleed, should not need to be set
        #before(:each) do
        #  CacheableFlash.configure do |config|
        #    config[:stacking] = false
        #  end
        #end
        it "should handle multiple keys" do
          get :multiple_keys
          flash_cookie['errors'].should == "This is an Error"
          flash_cookie['notice'].should == "This is a Notice"
        end
        it "should handle overriding values" do
          get :override
          flash_cookie['notice'].should_not == "original"
          flash_cookie['notice'].should == "message"
        end
        it "should handle stacking values as concatenations" do
          get :stack
          flash_cookie['notice'].should == "originalmessageanother"
        end
        it "should raise exception when cold booting the flash" do
          lambda { get :cold_boot }.should raise_exception
        end
      end
      describe "stacking" do
        before(:each) do
          CacheableFlash::Config.configure do |config|
            config[:stacking] = true
            config[:append_as] = :array
          end
        end
        after(:each) do
          StackableFlash.stacking = false
        end
        it "should handle multiple keys" do
          get :multiple_keys
          flash_cookie['errors'].should == ["This is an Error"]
          flash_cookie['notice'].should == ["This is a Notice"]
        end
        it "should handle overriding values" do
          get :override
          flash_cookie['notice'].should_not == ["original"]
          flash_cookie['notice'].should == ["message"]
        end
        it "should handle stacking values" do
          get :stack
          flash_cookie['notice'].should == ["original","message","another"]
        end
        it "should handle cold booting the flash" do
          get :cold_boot
          flash_cookie['notice'].should == ["original","message","another"]
        end
      end
    end
  end

end

