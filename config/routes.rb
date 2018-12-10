Rails.application.routes.draw do
	get '/new_category', to: 'categories#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup',  to: 'users#new'
  root 'static_pages#home'
  resources :users do
    patch 'set_admin', on: :member
  end
  resources :categories
end
