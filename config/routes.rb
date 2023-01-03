Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/destroy'
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#logged_in?'
  resources :users, only: [:create]
  resources :sessions, only: [:create, :destroy]

end
