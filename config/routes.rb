Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update,:follows,:followers] do
  	resource :relationships, only: [:create, :destroy]
  	get :follows, on: :member
  	get :followers, on: :member
  end
  resources :books
  root 'home#top'
  get '/home/about' => 'home#about'
end