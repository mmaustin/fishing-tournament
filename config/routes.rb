Rails.application.routes.draw do
  root 'application#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  #resources :sessions, only: [:create, :new, :destroy]
  resources :types
  resources :fish
  resources :anglers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
