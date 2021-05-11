Rails.application.routes.draw do
  root 'application#home'
  get '/signup', to: 'anglers#new'
  post '/signup', to: 'anglers#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :anglers, only: [:show] do
    resources :fish, only: [:show, :index, :new]
  end

  #resources :sessions, only: [:create, :new, :destroy]
  resources :types
  resources :fish
  resources :anglers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
