ActionController::Routing::Routes.draw do |map|
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  map.login '/login', :controller => 'user_session', :action => 'new'
  map.logout '/logout', :controller => 'user_session', :action => 'destroy'  
  
  map.resources :users do |user|
    user.resources :queries, :member => [:chart] do |query|
      query.resources :mentions, :only => [:index, :show]
    end
  end

  map.root :controller => "user_sessions", :action => "new" 
end
