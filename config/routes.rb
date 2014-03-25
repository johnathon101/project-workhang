ProjectWorkhang::Application.routes.draw do

  get "/users" => 'users#index', :as => :users
  get "/users/new" => 'users#new', :as => :new_user
  get "/users/:id/edit" => 'users#edit', :as => :edit_user
  get "/users/:id" => 'users#show', :as => :view_user

  get "/" => 'pages#home', :as => :home
  get "/checkin/:id" => 'check_ins#checkin', :as => :check_in
  get "/about" => 'pages#about', :as => :about
  get "/checkout/:id" => 'check_outs#checkout', :as => :checkout
  get "/logout" => 'pages#logout', :as => :logout
  post "/logins" => 'logins#create'
  delete "/logins/:id" => 'logins#destroy'
  resources :users
  resources :groups
  resources :places
end
