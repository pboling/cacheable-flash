#require 'spec_helper'
#
#module CacheableFlash
#  describe TestHelpers do
#    attr_reader :controller, :request, :response, :flash, :cookies
#    include TestHelpers
#    before do
#      @controller = ActionController::Base.new
#      @request = ActionDispatch::TestRequest.new
#      @response = ActionDispatch::TestResponse.new
#      controller.send(:initialize_template_class, response)
#      controller.send(:assign_shortcuts, request, response)
#
#      @flash = controller.send(:flash)
#      class << controller
#        include CacheableFlash
#      end
#    end
#
#    describe "#flash_cookie" do
#      it "returns the flash hash send as a cookie" do
#        expected_flash = {
#        'errors' => "This is an Error",
#        'notice' => "This is a Notice"
#        }
#        flash['errors'] = expected_flash['errors']
#        flash['notice'] = expected_flash['notice']
#
#        controller.write_flash_to_cookie
#        @cookies = response.cookies # simulate setting the cookie instance variable in rails tests
#
#        flash_cookie.should == expected_flash
#      end
#    end
#  end
#end
