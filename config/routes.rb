ProjectWorkhang::Application.routes.draw do

  get  "/places/new_manual/:name" => 'places#new_manual'
  post '/places/new_manual' =>'places#new_manual_save', :as => :new_manual_save

  # get "/checkin/:id" => 'pages#checkin', :as => :checkin
  get "/about" => 'pages#about', :as => :about
  # get "/checkout/:id" => 'pages#checkout', :as => :checkout
  get "/logout" => 'pages#logout', :as => :logout
  
  get "/checkout" => 'checkins#checkout', :as => :checkout
  post "/checkout/:id" => 'checkins#create', :as => :checkin

  resources :logins
  resources :users
  resources :groups
  resources :places
  resources :members
  resources :checkins
  
  root :to => 'pages#home'
  
end
