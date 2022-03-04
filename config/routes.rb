Rails.application.routes.draw do
  resources :comments
  resources :products
  devise_for :users
  resources :products do
    resources :comments
  end
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
