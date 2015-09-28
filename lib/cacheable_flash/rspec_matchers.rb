require 'stackable_flash/test_helpers'   # Used in the definition of these matchers
require 'stackable_flash/rspec_matchers' # Not used here, but for convenience
require 'cacheable_flash/test_helpers'   # Used in the definition of these matchers

module CacheableFlash
  module RspecMatchers
    include StackableFlash::TestHelpers
    include CacheableFlash::TestHelpers
    RSpec::Matchers.define :have_flash_cookie do |flash_status, expecting|
      define_method :has_flash_cookie? do |response|
        flash_in_stack(flash_cookie_for(response)[flash_status], expecting)
      end
      match{|response| has_flash_cookie?(response)}
      failure_message do |actual|
        "expected flash[:#{expected[0]}] to be or include #{expected[1].inspect}, but got #{flash_cookie_for(actual)[expected[0]]}"
      end
      failure_message_when_negated do |actual|
        "expected flash[:#{expected[0]}] to not be and not include #{expected[1].inspect}, but got #{flash_cookie_for(actual)[expected[0]]}"
      end
    end

    RSpec::Matchers.define :have_cacheable_flash do |flash_status, expecting|
      define_method :has_cacheable_flash? do |response|
        flash_in_stack(flash_cookie_for(response)[flash_status], expecting)
      end
      match{|response| has_cacheable_flash?(response)}
      failure_message do |actual|
        "expected flash[:#{expected[0]}] to be or include #{expected[1].inspect}, but got #{flash_cookie_for(actual)[expected[0]]}"
      end
      failure_message_when_negated do |actual|
        "expected flash[:#{expected[0]}] to not be and not include #{expected[1].inspect}, but got #{flash_cookie_for(actual)[expected[0]]}"
      end
    end

  end
end
