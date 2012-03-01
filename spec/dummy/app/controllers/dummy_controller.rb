class DummyController < ApplicationController
  def index
    expected_flash = {
    'errors' => "This is an Error",
    'notice' => "This is a Notice"
    }
    flash[:errors] = expected_flash['errors']
    flash[:notice] = expected_flash['notice']
  end
end
