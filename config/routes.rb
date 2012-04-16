StoreEngine::Application.routes.draw do

  get 'sessions/new', :as => 'login_page'
  post 'sessions/create', :as => 'login'
  delete 'sessions/destroy', :as => 'logout'

  resources :users, except: :destroy do
    member do
      put :view_as_admin
      put :view_as_normal
    end
  end

  resources :products
  resources :categories
  resources :orders, except: [:new, :create]
  resources :billing_methods, except: [:show, :index, :destroy]
  resources :line_items, except: [:show, :new, :index]
  resources :shipping_addresses, except: [:show, :index, :destroy]
  root to: "products#index"

end
