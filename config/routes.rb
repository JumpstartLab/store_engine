StoreEngine::Application.routes.draw do

  get 'sessions/new', :as => 'login_page'
  get 'sessions/index'
  post 'sessions/create', :as => 'login'
  delete 'sessions/destroy', :as => 'logout'

  match '/code' => redirect('http://github.com/athal7/store_engine')

  resources :users, except: :destroy do
    member do
      put :view_as_admin
      put :view_as_normal
    end
  end

  resources :products do
    member  do
      put :retire
    end
  end

  resources :categories
  resources :orders, except: [:new, :create]
  resources :billing_methods, except: [:destroy]
  resources :line_items, except: [:new]
  resources :shipping_addresses, except: [:destroy]
  root to: "products#index"

end
