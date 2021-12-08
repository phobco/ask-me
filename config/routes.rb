Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :questions, except: [:show, :new, :index]
  resource :session, only: [:new, :create, :destroy]
end
