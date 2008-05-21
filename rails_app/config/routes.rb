ActionController::Routing::Routes.draw do |map|
  map.resource :feed
  map.root :controller => "home"
end
