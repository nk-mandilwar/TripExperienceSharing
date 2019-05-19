Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'visited_locations#index'

  resources :friends, only: [:index, :destroy]
  resources :friend_requests, except: [:edit, :show]
  resources :users, only: :index
  resources :visited_locations, only: [:index, :create] do
  	collection do
  		get :all
  	end
  end
  resources :location_reviews, only: [:index, :new, :create]

end
