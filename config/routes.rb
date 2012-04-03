StoreEngine::Application.routes.draw do
  resources :categories, :products
  resource :shopping_cart, :controller => "shopping_cart"
end
