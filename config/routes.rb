Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resources :questions, except: [:show, :new, :index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :hashtags, only: [:show]

  get :sign_up, to: 'users#new'
  get :log_out, to: 'sessions#destroy'
  get :log_in, to: 'sessions#new'
end
