Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :friends, only: [:index, :destroy]
  resources :friend_requests, except: [:edit, :show]
  resources :users, only: :index

end
