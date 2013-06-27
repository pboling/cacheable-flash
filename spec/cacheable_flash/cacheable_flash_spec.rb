require 'spec_helper'

describe 'CacheableFlash' do
  attr_reader :controller_class, :controller, :cookies
  before do
    @controller_class = Struct.new(:cookies, :flash)
    @controller_class.stub(:around_filter)
    @controller_class.send(:include, CacheableFlash)
    @controller = @controller_class.new({}, {})
    @cookies = {}
    @controller.stub(:cookies).and_return(@cookies)
  end

  def controller_cookie_flash
    @controller.cookies['flash'][:value]
  end


  describe "#write_flash_to_cookie" do
    context "when there is not an existing flash cookie" do
      it "sets the flash cookie with a JSON representation of the Hash" do
        expected_flash = {
          'errors' => "This is an Error",
          'notice' => "This is a Notice"
        }
        @controller.flash = expected_flash.dup
        @controller.write_flash_to_cookie

        JSON(controller_cookie_flash).should == expected_flash
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
            'notice' => "New notice",
            'errors' => "New errors",
          }
          JSON(controller_cookie_flash).should == expected_flash
        end
      end

      context "when the flash cookie is 'invalid' json" do
        it "does not have an error and starts with an empty Hash" do
          @cookies['flash'] = ""
          lambda do
            JSON(@cookies['flash'])
          end.should raise_error(JSON::ParserError)

          @controller.write_flash_to_cookie

          JSON(@cookies['flash'][:value]).should == {}
        end
      end
    end
    
    it "converts flash value to string before storing in cookie if value is a number" do
      @controller.flash = { 'quantity' => 5 }
      @controller.write_flash_to_cookie
      JSON(controller_cookie_flash).should == { 'quantity' => 5 }
    end
    
    it "does not convert flash value to string before storing in cookie if value is anything other than a number" do
      @controller.flash = { 'foo' => { 'bar' => 'baz' } }
      @controller.write_flash_to_cookie
      JSON(controller_cookie_flash).should == { 'foo' => { 'bar' => 'baz' } }
    end
    
    it "encodes plus signs in generated JSON before storing in cookie" do
      @controller.flash = { 'notice' => 'Life, Love + Liberty' }
      @controller.write_flash_to_cookie
      controller_cookie_flash.should == "{\"notice\":\"Life, Love %2B Liberty\"}"
    end

    it "escapes strings when not html safe" do
      @controller.flash = { 'notice' => '<em>Life, Love + Liberty</em>' } # Not html_safe, so it will be escaped
      @controller.write_flash_to_cookie
      controller_cookie_flash.should == "{\"notice\":\"&lt;em&gt;Life, Love %2B Liberty&lt;/em&gt;\"}"
    end

    it "does not escape strings that are html_safe" do
      @controller.flash = { 'notice' => '<em>Life, Love + Liberty</em>'.html_safe } # html_safe so it will not be escaped
      @controller.write_flash_to_cookie
      controller_cookie_flash.should == "{\"notice\":\"<em>Life, Love %2B Liberty</em>\"}"
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
    
    it "escapes HTML if the flash value is not html safe" do
      @controller.flash = { 'quantity' => "<div>foobar</div>" }
      @controller.write_flash_to_cookie
      JSON(controller_cookie_flash).should == { 'quantity' => "&lt;div&gt;foobar&lt;/div&gt;" }
    end
    
    it "does not escape flash HTML if the value is html safe" do
      @controller.flash = { 'quantity' => '<div>foobar</div>'.html_safe }
      @controller.write_flash_to_cookie
      JSON(controller_cookie_flash).should == { 'quantity' => "<div>foobar</div>" }
    end
  end

  describe ".included" do
    it "sets the around_filter on the controller to call #write_flash_to_cookie" do
      @controller_class.should_receive(:around_filter).with(:write_flash_to_cookie)
      @controller_class.send(:include, CacheableFlash)
    end
  end
end
