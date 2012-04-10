StoreEngine::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  resource :cart, :only => [:show, :update]
  resources :users
  resources :orders
  resources :sessions
  resources :products
  resources :categories
  root :to => "products#index"
end
