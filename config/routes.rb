ActionController::Routing::Routes.draw do |map|
  map.resource :account, :controller => 'admin/users'
  map.resources :users
  
  map.resources :password_resets

  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.resource :user_session
  map.root :controller => 'user_sessions', :action => 'new'
  
  map.namespace :admin do |admin|
    admin.resources :users
  end
  
end