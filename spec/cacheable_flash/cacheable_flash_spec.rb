dir = File.dirname(__FILE__)
require File.expand_path("#{dir}/../spec_helper")

describe 'CacheableFlash' do
  attr_reader :controller_class, :controller, :cookies
  before do
    @controller_class = Struct.new(:cookies, :flash)
    stub(@controller_class).after_filter
    @controller_class.send(:include, CacheableFlash)
    @controller = @controller_class.new({}, {})
    @cookies = {}
    stub(@controller).cookies {@cookies}
  end

  describe "#write_flash_to_cookie" do
    context "when there is not an existing flash cookie" do
      it "sets the flash cookie with a JSON representation of the Hash" do
        expected_flash = {
          'errors' => "This is an Error",
          'notice' => "This is a Notice"
        }
        controller.flash = expected_flash.dup
        controller.write_flash_to_cookie

        JSON.parse(@controller.cookies['flash']).should == expected_flash
      end
    end

    context "when there is an existing flash cookie" do
      context "when the flash cookie is valid json" do
        it "appends new data to existing flash cookie" do
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
          JSON.parse(@controller.cookies['flash']).should == expected_flash
        end
      end

      context "when the flash cookie is 'invalid' json" do
        it "does not have an error and starts with an empty Hash" do
          @cookies['flash'] = ""
          lambda do
            JSON.parse(@cookies['flash'])
          end.should raise_error(JSON::ParserError)

          @controller.write_flash_to_cookie

          JSON.parse(@cookies['flash']).should == {}
        end
      end
    end

    it "clears the controller.flash hash provided by Rails" do
      flash = {
        'errors' => "This is an Error",
        'notice' => "This is a Notice"
      }
      @controller.flash = flash
      @controller.write_flash_to_cookie

      @controller.flash.should == {}
    end
  end

  describe ".included" do
    it "sets the after_filter on the controller to call #write_flash_to_cookie" do
      mock(@controller_class).after_filter(:write_flash_to_cookie)
      @controller_class.send(:include, CacheableFlash)
    end
  end
end
