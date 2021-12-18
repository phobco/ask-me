Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :questions, except: %i[show new index]
  resource :session, only: %i[new create destroy]
  resources :hashtags, only: :show, param: :text
end
