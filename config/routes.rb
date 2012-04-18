StoreEngine::Application.routes.draw do
  resources :category_assignments

  resources :categories

  match "/code" => redirect("https://github.com/eliseworthy/store_engine"), :as => :code
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  post "orders/one-click/:product_id" => "orders#one_click", :as => "one_click"

  resources :users
  resources :sessions
  resources :line_items
  resources :order_items
  resources :carts
  root to: "products#index"
  resources :products
  resources :orders do
    collection do
      get "admin_report"
    end
  end
end
  