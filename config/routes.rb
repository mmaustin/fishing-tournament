Rails.application.routes.draw do
  root 'application#home'
  get '/signup', to: 'anglers#new'
  post '/signup', to: 'anglers#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth/:provider/callback' => 'sessions#omniauth'
  get '/logout', to: 'sessions#destroy'
  #get '/delete_profile', to: 'anglers#destroy'

  resources :anglers do
    resources :fish, only: [:show, :index, :new]
  end


  resources :types
  resources :fish
  resources :anglers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
