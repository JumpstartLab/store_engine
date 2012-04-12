StoreEngine::Application.routes.draw do
  resources :categories
  resources :products
  resource :shopping_cart, :controller => "shopping_cart"
  resources :user_sessions
  resources :users
  resources :cart_items
  resources :shipping_addresses
  resources :billing_addresses
  resource :order_summary,  :controller => "order_summary"
  resources :orders

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  root :to => 'users#index'
end
