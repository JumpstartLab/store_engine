StoreEngine::Application.routes.draw do

  resources :products, :only => [:index, :show]
  resource :shopping_cart, :controller => "shopping_cart"
  resources :user_sessions
  resources :users
  resources :cart_items
  resources :shipping_addresses
  resources :billing_addresses
  resource :order_summary,  :controller => "order_summary"
  resources :orders
  resources :transactions
  resource :checkout, :controller => "checkout"
  resources :order_items, :only => :destroy
  resources :categories do
    resources :products, :only => [:index], :controller => "categories_products"
  end

  namespace :admin do
    resources :products
    resources :categories
    resources :dashboard, :controller => "dashboard", :only => [:index]
  end

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match "/code" => redirect("https://github.com/mrgilman/store_engine"), :as => :code
  root :to => 'products#index'
end
