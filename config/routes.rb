StoreEngine::Application.routes.draw do

  resource :cart, :only => [:show, :update]
  resources :orders
  resources :products
  resources :categories
end
