class DummyController < ApplicationController
  include CacheableFlash
  def index
    expected_flash = {
    'errors' => "This is an Error",
    'notice' => "This is a Notice"
    }
    flash[:errors] = expected_flash['errors']
    flash[:notice] = expected_flash['notice']
  end

  def error
    expected_flash = {
    'errors' => "This is a real Error",
    }
    flash[:errors] = expected_flash['errors']
  end

  def no_flash
    # Does not set any flash
  end
end
