Rails.application.routes.draw do
  root :controller => 'dummy', :action => 'index' 
  mount CacheableFlash::Engine => "/cacheable_flash"
end
