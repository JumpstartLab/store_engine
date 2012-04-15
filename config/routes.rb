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

  namespace :admin do
    resources :products
    resources :categories
  end

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  root :to => 'users#index'
end
