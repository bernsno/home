ActionController::Routing::Routes.draw do |map|
  # Users
  map.resources :users
  map.resources :password_resets
  map.signup '/signup', :controller => 'users', :action => 'new'

  # Activation
  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'activations', :action => 'create'

  # Sessions
  map.resource :user_session
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  # Admin
  map.namespace :admin do |admin|
    admin.resources :users
    
    admin.root :controller => "users"
  end

  # Root
  map.root :controller => 'user_sessions', :action => 'new'

end