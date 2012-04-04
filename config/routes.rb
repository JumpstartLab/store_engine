StoreEngine::Application.routes.draw do
  resources :categories
  resources :products
  resource :shopping_cart, :controller => "shopping_cart"
  resources :cart_items
  resources :user_sessions
  resources :users

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  root :to => 'users#index'
end
