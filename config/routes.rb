ActionController::Routing::Routes.draw do |map|
  
  # #map.root :controller => 'home', :action => 'index'
  # 
  #   map.resources :home, :path_prefix => ":locale"
  #   #map.resources :categories, :path_prefix => ":locale"
  #   #map.resources :articles, :path_prefix => ":locale"
  #   map.connect ":locale/article/:id", :controller => "articles", :action => "show"
  #   #, :id => /$(\d)-/, :locale => /[a-z]{2}/
  #   map.connect ":locale/category/:id", :controller => "categories", :action => "show"
  #   #, :id => /$(\d)-/, :locale => /[a-z]{2}/
  #   
  #   
  #   #map.resources :users
  #   map.resource :user_session
  #   map.resource :account, :controller => "users"
  #   map.login "login", :controller => "user_sessions", :action => "new"
  #   map.logout "logout", :controller => "user_sessions", :action => "destroy"
  #   map.signin "signin", :controller => "users", :action => "new"
  #   map.resources :password_resets
  #   map.activate '/activate/:id', :controller => 'activations', :action => 'create'
  #   map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  #   
  #   
  #   map.namespace(:admin) do |admin|   
  #     admin.home '/', :controller => "cms/articles"
  #     admin.resources :site_settings
  #     admin.resources :users, :member => {
  #       :activate => :get,
  #       :desactivate => :get
  #     }  
  #     admin.namespace(:cms) do |cms|
  #       cms.home '/', :controller => "articles"
  #       cms.resources :articles, :member => {
  #         :publish => :get,
  #         :unpublish => :get,
  #         :archive => :get,
  #         :unarchive => :get,
  #       }
  #       cms.resources :categories
  #       cms.resources :attached_documents
  #     end
  #     admin.resources :assets, :collection => {
  #       :gallery => :get,
  #       :list => :get
  #     }
  #   end
end
