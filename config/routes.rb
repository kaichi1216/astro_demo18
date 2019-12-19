Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tasks#index"
  # get 'sessions/new'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  #使用 collection 要對複數資料做操作
  resources :tasks do
    collection do
      get :search
    end
  end

  resources :users, controller: 'users'
  namespace :admin do
    root 'user#index'
    resources :users
  end

  #加上錯誤頁面導向 如需處理其他新的錯誤頁面 方便再擴增
  %w(404 422 500).each do |code|
    get code, to: "errors#show", code: code
  end
end
