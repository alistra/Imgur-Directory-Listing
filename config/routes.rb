ActionController::Routing::Routes.draw do |map|
  
  map.resources :images, :only => ["index", "show"]
  map.partial '/:partial', :controller => "images", :action => "search", :requirements => { :partial => /.+/ }

  map.root :controller => "images", :action => "index"
end
