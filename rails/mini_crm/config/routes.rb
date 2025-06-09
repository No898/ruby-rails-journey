Rails.application.routes.draw do
  get "posts/index"
  get "home/index"
  devise_for :users
  resources :contacts do
    resources :notes, only: [:create]
  end
  
  resources :notes
  resources :posts

  resource :chat, only: [:create], controller: 'chat'

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end
