ActionController::Routing::Routes.draw do |map|
  
  map.resource :user_session
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'  
  
  map.resources :users do |user|
    user.resources :queries, :member => [:chart] do |query|
      query.mentions_by_type 'mentions_by_type/:type', :controller => 'mentions', :action => 'by_type'
      query.resources :mentions, :only => [:index, :show]
    end
  end

  map.root :controller => "user_sessions", :action => "new" 
end
