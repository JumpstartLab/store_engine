StoreEngine::Application.routes.draw do

  resources :users, only: [:show, :create, :new, :update]

  resource  :cart, only: [:show, :update]
  resources :sessions
  resources :cart_products, only: [:new, :update, :destroy]
  # resource  :cart_product, only: []
  resources :products, only: [:index, :show] do
    resource :retirement, only: :create
    resource :categories, only: :show
  end
  resources :categories , only: [:show]
  resources :orders, only: [:index, :new, :show, :create]
  resources :credit_cards, only: [:new, :create, :index]

  namespace :admin do
    resources :products
    resources :categories
    resources :orders, only: [:index, :show, :update]
    resources :users, only: [:show]
    resource :dashboards, only: [:show]
  end

  match '/admin/orders/:id/mark_shipped', as: :admin_orders_mark_shipped, :to => 'admin/orders#mark_shipped', via: :put
  match '/admin/orders/:id/mark_cancelled', as: :admin_orders_mark_cancelled, :to => 'admin/orders#mark_cancelled', via: :put
  match '/admin/orders/:id/mark_returned', as: :admin_orders_mark_returned, :to => 'admin/orders#mark_returned', via: :put
  match '/admin/dashboard', :to => 'admin/dashboard#show'
  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy', via: :delete

  root :to => "static_pages#home"

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
