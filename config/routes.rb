ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }

  map.resource :session

  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil

  map.connect '/api/username_from_md5/:identifier_hash', :controller => "api", :action => "username_from_md5"

  map.connect '/api/github/post_receive', :controller => "api", :action => "github_post_receive"

  map.connect '/api/sandbox_test', :controller => "api", :action => "sandbox_test"

  map.account "/account", :controller => "users", :action => "account"
  
  map.page ":action", :controller => "page"
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "page", :action => "index"

end
