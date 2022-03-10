Rails.application.routes.draw do
  get 'shops/index'
  get 'shops/show'
  get 'carts', to: 'carts#show'
  resources :comments
  resources :products
  devise_for :users
  resources :products do
    resources :comments
  end
  resources :line_items
  resource :carts, only:[:show]
  resources :shops, only:[:index, :show]
  root 'shops#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
