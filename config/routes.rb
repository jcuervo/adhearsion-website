ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'

  map.resource :session

  map.connect '/api/username_from_md5/:identifier_hash', :controller => "api", :action => "username_from_md5"

  map.connect '/api/github/post_receive', :controller => "api", :action => "github_post_receive"

  map.connect '/api/sandbox_test', :controller => "api", :action => "sandbox_test"

  map.page ":action", :controller => "page"
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "page", :action => "index"

end
