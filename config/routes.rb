Rails.application.routes.draw do
  resources :tools

  resources :users

  namespace :user do
    resources :tools
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'users#new'

end
