StoreEngine::Application.routes.draw do
  root to: 'products#index'

  get "/logout" => "sessions#destroy", :as => "logout"
  get "/login" => "sessions#new", :as => "login"
  get "/signup" => "users#new", :as => "signup"

  match "/account" => redirect("/account/profile")
  match "/account/profile" => "users#show"
  match "/account/orders" => "orders#index"
  get "/account/orders/:id" => "orders#show", :as => "account_order"
  post "/buy_now" => "orders#buy_now", :as => 'buy_now'

  resources :sessions, only: [ :new, :create, :destroy ]
  resources :products, only: [ :index, :show ]

  resource :cart, only: [ :update, :show, :destroy ] do
    member do
      put :remove_item
    end
  end

  resources :users, only: [ :new, :create, :update ] do
    resources :orders
  end

  namespace :admin do
    root to: redirect("/admin/dashboard")
    get :dashboard, to: "orders#index", as: 'dashboard'
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
