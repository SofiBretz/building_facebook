Rails.application.routes.draw do
  devise_scope :user do
    root 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
    get 'logout', to: 'devise/sessions#destroy'
  end
  devise_for :users
  resources :posts, only: [:index, :show, :new, :create]
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
