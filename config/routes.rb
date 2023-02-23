Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks], controllers: {
        registrations: 'api/v1/auth/registrations',
      }
      namespace :auth do
        resources :sessions, only: [:index]
      end
      resources :posts
      resources :certificates, only: [:index]
      get 'alb/health_check', to: 'alb#health_check'
    end
  end
  # mount_devise_token_auth_for 'User', at: 'auth'
  get '/follows', to: 'follows#index'
  post '/follow', to: 'follows#create'
  post '/unfollow', to: 'follows#destroy'
  get '/bookmarks', to: 'bookmarks#index'
  post '/bookmark', to: 'bookmarks#create'
  post '/unbookmark', to: 'bookmarks#destroy'
  get '/posts', to: 'posts#index'
  get '/posts/:id', to: 'posts#show'
  post '/post', to: 'posts#create'
  patch '/post', to: 'posts#update'
  get 'certificates', to: 'certificates#index'
  post '/signup', to: 'users#create'
  patch '/user', to: 'users#update'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#logged_in?'
  get 'certificates', to: 'certificates#index'
  resources :users, only: [:create, :update]
  resources :posts
  resources :sessions, only: [:create, :destroy]
  resources :certificates, only: [:index]
  get '/', to: 'api/v1/alb#health_check'
end
