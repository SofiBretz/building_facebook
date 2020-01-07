Rails.application.routes.draw do
  devise_scope :user do

    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
    get 'logout', to: 'devise/sessions#destroy'
  end
  devise_for :users
  root 'posts#index'
  resources :posts, only: [:index, :show, :new, :create]
  resources :users, only: [:index, :show]
  resources :comments, only: [:new, :create]
  resources :likes, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
