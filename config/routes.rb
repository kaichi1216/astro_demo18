Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tasks#index"
  get 'sessions/new'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :tasks do
    collection do
      get :search
    end
  end
  resources :users, controller: 'users'

  resources :sessions

  namespace :admin do
    root 'user#index'
    resources :users
  end
end
