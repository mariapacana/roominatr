Roominatr::Application.routes.draw do



  match '/default_image', to: 'users#default_image', as: 'user_default_image'
  match '/default_home', to: 'houses#default_image', as: 'home_default_image'
  match '/users/search', to: 'users#search', :via => :get, as: 'users_search'
  match '/users/search_no_house', to: 'users#search_no_house', :via => :get, as: 'users_search_no_house'
  match '/users/search_house', to: 'users#search_house', :via => :get, as: 'users_search_house'
  match '/users/show_top_users', to: 'users#show_top_users', :via => :get, as: 'top_users'
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

  resources :users do
    resource :houses
  end

  root to: 'homepage#show'

end
