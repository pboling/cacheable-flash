require 'spec_helper'

# Controller specs do not hit the full rails stack, and Middleware is ignored.
# For this reason testing in the controller must rely on the around filter,
# even if you are actually using the Middleware in your actual app
# The DummyController in the dummy app includes CacheableFlash to make the helpers testable as a controller spec.

describe DummyController, type: :controller do

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
          expect(flash_cookie['errors']).to eq("This is an Error")
          expect(flash_cookie['notice']).to eq("This is a Notice")
        end
        it "should handle overriding values" do
          get :override
          expect(flash_cookie['notice']).to_not eq("original")
          expect(flash_cookie['notice']).to eq("message")
        end
        it "should handle stacking values as concatenations" do
          get :stack
          expect(flash_cookie['notice']).to eq("originalmessageanother")
        end
        it "should raise exception when cold booting the flash" do
          expect { get :cold_boot }.to raise_error NoMethodError, /undefined method `<<' for nil:NilClass/
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
          expect(flash_cookie['errors']).to eq(["This is an Error"])
          expect(flash_cookie['notice']).to eq(["This is a Notice"])
        end
        it "should handle overriding values" do
          get :override
          expect(flash_cookie['notice']).to_not eq(["original"])
          expect(flash_cookie['notice']).to eq(["message"])
        end
        it "should handle stacking values" do
          get :stack
          expect(flash_cookie['notice']).to eq(["original","message","another"])
        end
        it "should handle cold booting the flash" do
          get :cold_boot
          expect(flash_cookie['notice']).to eq(["original","message","another"])
        end
      end
    end
  end

end

