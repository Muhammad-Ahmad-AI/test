Rails.application.routes.draw do
  get 'search' , to: 'search#index'
  get 'shops/index'
  get 'shops/show'
  # resources :carts
  get 'carts', to: 'carts#index'
  resources :comments
  resources :products
  devise_for :users
  resources :products do
    resources :comments
  end
  resources :line_items
  # resource :carts, only:[:show]
  resources :orders, only: [:index, :create, :show]
  resources :shops, only:[:index]
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
