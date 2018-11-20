Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :tasks do
    member do
      post :start
      post :done
    end
  end
  # resources :users, only: %i[new create edit update show]
  resource :user, controller: 'users'
  resources :sessions

  namespace :admin do
    root 'users#index'
    resources :users
  end

end
