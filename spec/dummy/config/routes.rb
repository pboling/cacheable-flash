Rails.application.routes.draw do
  root :controller => 'dummy', :action => 'index'

  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
