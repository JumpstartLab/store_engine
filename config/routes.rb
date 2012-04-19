StoreEngine::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "checkout" => "carts#checkout", :as => "checkout"
  get "billing" => "users#billing", :as => "billing"
  post "billing" => "users#create_billing", :as => "billing"
  get "add_category_to_product" => "admin/categories#add_product", :as => "add_category_to_product"

  resource :cart, :only => [:show, :update]
  resources :users
  resources :orders
  resource :cart_item, :only => [:destroy]
  resources :sessions
  resources :products
  resources :categories
  
  namespace :admin do
    resources :orders
    resources :order_items
    resources :products
    resources :categories
    resource :dashboard
  end

  root :to => "products#index"
end
