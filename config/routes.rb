StoreEngine::Application.routes.draw do

  resource :cart, :only => [:show, :update]
  resources :orders
  resources :products
end
