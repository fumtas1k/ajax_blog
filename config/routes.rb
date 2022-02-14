Rails.application.routes.draw do
  root "blogs#index"
  resources :users
  resources :blogs do
    resources :comments
  end
  resources :sessions, only: %i[ new create destroy ]
  resources :relationships, only: %i[ create destroy ]
end
