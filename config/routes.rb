Rails.application.routes.draw do
  root 'static_pages#home'
  # root to: 'tasks#index'
  # resources :tasks, only: [:index, :show, :create, :destroy] do
  resources :tasks, only: [:show, :create, :destroy] do
    resource :reactions, only: [:create, :destroy]
  end

  resources :users, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      get :name_edit
      patch :update_name
      get :edit_password
      patch :update_password
      get :new_sub
      post :create_sub
    end
  end

  resources :groups, only: [:show, :new, :create, :edit, :update, :destroy] do
    member do
      post :set_defaultuser
    end
  end

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # get 'tasks/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
