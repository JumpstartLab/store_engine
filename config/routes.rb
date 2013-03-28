StoreEngine::Application.routes.draw do
  root to: 'products#index'

  get "/logout" => "sessions#destroy", :as => "logout"
  get "/login" => "sessions#new", :as => "login"
  get "/signup" => "users#new", :as => "signup"

  resources :sessions, only: [ :new, :create, :destroy ]

  resources :products, only: [ :index, :show ]

  resource :cart, only: [ :update, :show, :destroy ]

  resources :users do
    resources :orders
  end

  match "/admin" => redirect("/admin/dashboard")
  match "/admin/dashboard" => "admin/orders#index"

  namespace :admin do

    resources :orders, only: [ :show, :update ]

    resources :order_items, only: [ :update, :destroy]

    resources :products do
      member do
        post :retire
        post :activate
      end
    end

    resources :categories, except: [ :show ]
  end
end
