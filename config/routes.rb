Rails.application.routes.draw do
  root 'application#home'
  resources :sessions, only: [:new, :create, :destroy]
  resources :types
  resources :fish
  resources :anglers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
