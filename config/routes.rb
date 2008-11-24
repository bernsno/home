ActionController::Routing::Routes.draw do |map|
  map.resource :account, :controller => 'users'
  map.resources :users
  
  map.resources :password_resets

  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.resource :user_session
  map.root :controller => 'user_sessions', :action => 'new'
end