StoreEngine::Application.routes.draw do

  get 'sessions/new', :as => 'login_page'
  post 'sessions/create', :as => 'login'
  delete 'sessions/destroy', :as => 'logout'

  resources :users do
    member do
      put :view_as_admin
      put :view_as_normal
    end
  end

  resources :products
  resources :categories
  resources :orders
  resources :billing_methods
  resources :line_items
  resources :shipping_addresses
  root to: "products#index"

end
