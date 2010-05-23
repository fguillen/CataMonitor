ActionController::Routing::Routes.draw do |map|
  
  map.resource :user_session
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'  
  
  map.resources :users do |user|
    user.resources :queries, :member => [:process_mentions] do |query|
      query.mentions_by_type 'mentions_by_type/:type/days/:num_days', :controller => 'mentions', :action => 'by_type', :num_days => '30'
      query.mentions_chart 'mentions_chart/days/:num_days', :controller => 'mentions', :action => 'chart', :num_days => '30'
      query.resources :mentions, :only => [:index]
    end
  end

  map.root :controller => "user_sessions", :action => "new" 
end
