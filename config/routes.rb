Zeinerdsgn::Application.routes.draw do
  
  
    # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  
  root :to => 'pages#index'
  
=begin
  get "users/show"
  get "users/new"
  get "users/create"
=end
  get 'pages/home'
  get 'pages/about'
  get 'pages/contacts'
  post 'pages/contacts'
  get 'pages/services'
  
  get 'pages/thankyou'
  
=begin
  get 'pages/projects'
  
  get 'pages/quote'
  post 'pages/quote'
  get 'pages/register'
  get 'pages/passwordreset'
  post 'pages/passwordreset'

  get "quotes/index"
  get 'quotes/quote_first'
  post 'quotes/quote_first'
  get 'quotes/quote_second'
  post 'quotes/quote_second'
  get 'quotes/quote_third'
  post 'quotes/quote_third'
  get 'quotes/quote_fourth'
  post 'quotes/quote_fourth'
  
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  
  #match "users/:id/passwordreset" => "users/passwordreset", :as => :passwordreset
  get 'users/passwordreset'
  post 'users/passwordreset'
  
  get 'support/ansadmin'
  get 'support/adminlogin'
  post 'support/adminlogin'
  
  get 'support/manageusers'
  get 'support/findallmatchingusers'
  
  resource :session
  resources :users
  resources :quotes
=end
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
