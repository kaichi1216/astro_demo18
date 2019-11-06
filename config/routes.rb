Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks do
    collection do
      get :search
    end
  end

  resources :users
  get '/signup', to: 'user#new'

  root "tasks#index"
end
