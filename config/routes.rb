Bachelor::Application.routes.draw do

  # Start page
  root :to => "dashboard#index"

  # Generic Model
  resources :generic_tables, :only => :index #get "generic_tables/index"
  namespace :generic_table do
    resources :fact_values
    resources :dimension_values
    resources :aggregations
    resources :dimensions
  end

  # Star-Schema
  namespace :star do
    resources :customers
    resources :products
    resources :branches
    resources :dates
    resources :facts
  end

  # Comparisons
  resources :comparisons, :only => [:index]

  # Generate data
  resources :generate_data, :only => [:index, :destroy] do
    put :generate_star_data, :on => :collection
    get :copy_attrs_from_star, :on => :collection
    get :copy_dimension_data_from_star, :on => :collection
    get :copy_fact_data_from_star, :on => :collection
    get :copy_star_completely, :on => :collection
  end

  ############################# INFO ###############################################
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
