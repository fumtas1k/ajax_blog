Rails.application.routes.draw do
  root "blogs#index"
  resources :users
  resources :blogs
  resources :sessions, only: %i[ new create destroy ]
end
