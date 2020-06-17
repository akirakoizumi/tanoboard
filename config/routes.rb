Rails.application.routes.draw do
  resources :users
  get  '/signup', to: 'users#new'

  root to: 'tasks#index'
  # get 'tasks/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
