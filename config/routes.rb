Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'

  resources :users, only: [:new]
  get '/login', to: 'sessions#create'

  resources :landmarks, only: [:index]
end
