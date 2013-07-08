Roominatr::Application.routes.draw do

  match '/default_pic', to: 'users#default_image', as: 'user_default_image'
  match '/users/search', to: 'users#search', :via => :get, as: 'users_search'
  resources :users
  match '/users/:id/picture', to: 'users#update_picture', via: :put, as: 'user_picture'
  match '/users/:id/password', to: 'users#edit_password', via: :get, as: 'user_password'
  match '/users/:id/password', to: 'users#update_password', via: :put, as: 'user_password'


  resources :sessions, :only => [:new, :create, :destroy]
  match '/signout', to: 'sessions#destroy'
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'

  resources :surveys, :only => [:new, :create, :show]
  resources :responses, :only => [:new, :create, :edit, :update]
  resources :submissions, :only => [:new, :create, :edit, :update, :destroy]
  resources :homepage

  root to: 'homepage#show'

end
