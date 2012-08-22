require 'cacheable_flash/test_helpers'

module CacheableFlash
  module RspecMatchers
    include CacheableFlash::TestHelpers
    RSpec::Matchers.define :have_flash_cookie do |flash_status, expecting|
      define_method :has_flash_cookie? do |response|
        flash = testable_flash(response)[flash_status]
        if flash.kind_of?(Array)
          if expecting.kind_of?(Array)
            flash == expecting
          else
            matches = flash.select do |to_check|
              to_check == expecting
            end
            matches.length > 0
          end
        else
          flash == expecting
        end
      end

      match{|response| has_flash_cookie?(response)}

      failure_message_for_should do |actual|
        "expected that flash cookie :#{expected[0]} #{testable_flash(actual)[expected[0]]} would include #{expected[1].inspect}"
      end
      failure_message_for_should_not do |actual|
        "expected that flash cookie :#{expected[0]} #{testable_flash(actual)[expected[0]]} would not include #{expected[1].inspect}"
      end
    end
  end
end
