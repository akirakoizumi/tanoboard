Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :users do
    member do
      get :edit_password
      patch :update_password
    end
  end

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :groups, only: [:index, :show, :new, :create]

  # get 'tasks/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
