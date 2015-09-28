require 'spec_helper'

# Controller specs do not hit the full rails stack, and Middleware is ignored.
# For this reason testing in the controller must rely on the around filter,
# even if you are actually using the Middleware in your actual app
# The DummyController in the dummy app includes CacheableFlash to make the helpers testable as a controller spec.

describe ComparisonController, type: :controller do

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
        it "should handle comparison with hash through keys" do
          get :single_key_hash
          expect(flash_cookie['notice']).to eq({'hello' => 'asdf'}) # Keys of hashes are always strings on the other side of JSON
        end
        it "should handle comparison with number" do
          get :single_key_number
          expect(flash_cookie['notice']).to eq(1)
        end
        it "should handle comparison with string" do
          get :single_key_string
          expect(flash_cookie['notice']).to eq('message')
        end
        it "should handle comparison with array" do
          get :single_key_array
          expect(flash_cookie['notice']).to eq(['message']) # Because actually set to an array, not because stacking
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
        it "should handle comparison with hash through keys" do
          get :single_key_hash
          expect(flash_cookie['notice']).to eq([{'hello' => 'asdf'}]) # Keys of hashes are always strings on the other side of JSON
        end
        it "should handle comparison with number" do
          get :single_key_number
          expect(flash_cookie['notice']).to eq([1])
        end
        it "should handle comparison with string" do
          get :single_key_string
          expect(flash_cookie['notice']).to eq(['message']) # flash was set to a string, but comparison is with an array!
        end
        it "should handle comparison with array" do
          get :single_key_array
          expect(flash_cookie['notice']).to eq(['message'])
        end
      end
    end
  end

  describe "CacheableFlash::RspecMatchers" do
    describe "have_cacheable_flash" do
      describe "not stacking" do
        # This is default, so, as long as other tests don't bleed, should not need to be set
        #before(:each) do
        #  CacheableFlash.configure do |config|
        #    config[:stacking] = false
        #  end
        #end
        describe "test against string" do
          before(:each) do
            get :single_key_string
          end
          context "#should" do
            it "raises error when not a match" do
              expect { expect(response).to have_cacheable_flash('notice','not message')}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when a match" do
              expect { expect(response).to have_cacheable_flash('notice','message')}.to_not raise_error
            end
          end
          context "#should_not" do
            it "raises error when a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','message')}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when not a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','not message')}.to_not raise_error
            end

          end
        end
        describe "test against array" do
          before(:each) do
            get :single_key_array
          end
          context "#should" do
            it "raises error when not a match" do
              expect { expect(response).to have_cacheable_flash('notice','not message')}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when a match" do
              expect { expect(response).to have_cacheable_flash('notice','message')}.to_not raise_error
            end
          end
          context "#should_not" do
            it "raises error when a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','message')}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when not a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','not message')}.to_not raise_error
            end
          end
        end
        describe "test against hash" do
          before(:each) do
            get :single_key_hash
          end
          context "#should" do
            it "raises error when not a match" do
              expect { expect(response).to have_cacheable_flash('notice','not message')}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when a match" do
              expect { expect(response).to have_cacheable_flash('notice',{'hello' => 'asdf'})}.to_not raise_error
            end
          end
          context "#should_not" do
            it "raises error when a match" do
              expect { expect(response).to_not have_cacheable_flash('notice',{'hello' => 'asdf'})}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when not a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','not message')}.to_not raise_error
            end

          end
        end
        describe "test against number" do
          before(:each) do
            get :single_key_number
          end
          context "#should" do
            it "raises error when not a match" do
              expect { expect(response).to have_cacheable_flash('notice',2)}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when a match" do
              expect { expect(response).to have_cacheable_flash('notice',1)}.to_not raise_error
            end
          end
          context "#should_not" do
            it "raises error when a match" do
              expect { expect(response).to_not have_cacheable_flash('notice',1)}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when not a match" do
              expect { expect(response).to_not have_cacheable_flash('notice',2)}.to_not raise_error
            end
          end
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
        describe "test against string" do
          before(:each) do
            get :single_key_string
          end
          context "#should" do
            it "raises error when not a match" do
              expect { expect(response).to have_cacheable_flash('notice','not message')}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when a match" do
              expect { expect(response).to have_cacheable_flash('notice','message')}.to_not raise_error
              expect { expect(response).to have_cacheable_flash('notice',['message'])}.to_not raise_error
            end
          end
          context "#should_not" do
            it "raises error when a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','message')}.to raise_error RSpec::Expectations::ExpectationNotMetError
              expect { expect(response).to_not have_cacheable_flash('notice',['message'])}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when not a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','not message')}.to_not raise_error
            end

          end
        end
        describe "test against array" do
          before(:each) do
            get :single_key_array
          end
          context "#should" do
            it "raises error when not a match" do
              expect { expect(response).to have_cacheable_flash('notice',['not message'])}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when a match" do
              expect { expect(response).to have_cacheable_flash('notice','message')}.to_not raise_error
              expect { expect(response).to have_cacheable_flash('notice',['message'])}.to_not raise_error
            end
          end
          context "#should_not" do
            it "raises error when a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','message')}.to raise_error RSpec::Expectations::ExpectationNotMetError
              expect { expect(response).to_not have_cacheable_flash('notice',['message'])}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when not a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','not message')}.to_not raise_error
            end
          end
        end
        describe "test against hash" do
          before(:each) do
            get :single_key_hash
          end
          context "#should" do
            it "raises error when not a match" do
              expect { expect(response).to have_cacheable_flash('notice','not message')}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when a match" do
              expect { expect(response).to have_cacheable_flash('notice',{'hello' => 'asdf'})}.to_not raise_error
              expect { expect(response).to have_cacheable_flash('notice',[{'hello' => 'asdf'}])}.to_not raise_error
            end
          end
          context "#should_not" do
            it "raises error when a match" do
              expect { expect(response).to_not have_cacheable_flash('notice',{'hello' => 'asdf'})}.to raise_error RSpec::Expectations::ExpectationNotMetError
              expect { expect(response).to_not have_cacheable_flash('notice',[{'hello' => 'asdf'}])}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when not a match" do
              expect { expect(response).to_not have_cacheable_flash('notice','not message')}.to_not raise_error
            end

          end
        end
        describe "test against number" do
          before(:each) do
            get :single_key_number
          end
          context "#should" do
            it "raises error when not a match" do
              expect { expect(response).to have_cacheable_flash('notice',2)}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when a match" do
              expect { expect(response).to have_cacheable_flash('notice',1)}.to_not raise_error
              expect { expect(response).to have_cacheable_flash('notice',[1])}.to_not raise_error
            end
          end
          context "#should_not" do
            it "raises error when a match" do
              expect { expect(response).to_not have_cacheable_flash('notice',1)}.to raise_error RSpec::Expectations::ExpectationNotMetError
              expect { expect(response).to_not have_cacheable_flash('notice',[1])}.to raise_error RSpec::Expectations::ExpectationNotMetError
            end
            it "should not raise error when not a match" do
              expect { expect(response).to_not have_cacheable_flash('notice',2)}.to_not raise_error
            end
          end
        end
      end
    end
  end
end

