ProjectWorkhang::Application.routes.draw do

  get  "/places/new_manual" => 'places#new_manual', :as => :create_manually
  post '/places/new_manual' =>'places#new_manual_save', :as => :new_manual_save

  # get "/checkin/:id" => 'pages#checkin', :as => :checkin
  get "/about" => 'pages#about', :as => :about
  # get "/checkout/:id" => 'pages#checkout', :as => :checkout
  get "/logout" => 'pages#logout', :as => :logout
  get "/groups/:id/delete" => 'groups#delete_confirm', :as => :delete_confirm
  get "/groups/:id/ban" => 'groups#ban_confirm', :as => :ban_confirm
  post "/places/results" => "places#results"
  get "/places/check_db/:lng/:lat/:pos" => "places#check_db"
  
  get "/checkout" => 'checkins#checkout', :as => :checkout
  post "/checkout/:id" => 'checkins#create', :as => :checkin

  resources :logins
  resources :users
  resources :groups
  resources :places
  resources :members
  resources :checkins
  
  post "/groups/:id/leave" => 'groups#leave', :as => :leave
  post "/groups/:id/join" => 'groups#join', :as => :join
  
  root :to => 'pages#home'
  
end
