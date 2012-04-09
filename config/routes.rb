StoreEngine::Application.routes.draw do

  get 'sessions/new', :as => 'login_page'
  post 'sessions/create', :as => 'login'
  delete 'sessions/destroy', :as => 'logout'

  resources :users
  resources :products
  resources :categories
  resources :orders
  resources :billing_methods
  resources :line_items
  root to: "products#index"

end
