Roominatr::Application.routes.draw do

  resources :users
  match '/users/:id/picture', to: 'users#update_picture', via: :put, as: 'user_picture'
  match '/users/:id/password', to: 'users#edit_password', via: :get, as: 'user_password'
  match '/users/:id/password', to: 'users#update_password', via: :put, as: 'user_password'
  match '/signout', to: 'sessions#destroy'
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :surveys, :only => [:new, :create, :show]
  resources :responses, :only => [:new, :create, :edit, :update]
  resources :submissions, :only => [:new, :create, :edit, :update]

  root to: 'sessions#new'

end
