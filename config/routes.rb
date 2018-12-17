Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup',  to: 'users#new'
  root 'static_pages#home'

  resources :lessons do
    resources :answers
  end

  resources :categories
  
  resources :users do
    patch 'set_admin', on: :member
  end

  namespace :admin do
    resources :categories do
      resources :words
    end
    resources :choices
  end
end