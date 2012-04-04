StoreEngine::Application.routes.draw do
  resources :categories, :products
  resource :shopping_cart, :controller => "shopping_cart"

  root :to => 'users#index'
  resources :user_sessions
  resources :users

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
end
