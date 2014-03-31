ProjectWorkhang::Application.routes.draw do

  get  "/places/new_manual" => 'places#new_manual', :as => :create_manually
  post '/places/new_manual' =>'places#new_manual_save', :as => :new_manual_save
  get "/places/new_review" => 'places#new_review', :as => :new_review
  post "/places/new_review" => 'places#new_review_save', :as => :new_review_save
  
  get "/about" => 'pages#about', :as => :about
  get "/logout" => 'pages#logout', :as => :logout
  get "/groups/:id/delete" => 'groups#delete_confirm', :as => :delete_confirm
  get "/groups/:group_id/ban/:user_id" => 'groups#ban_confirm', :as => :ban
  delete "/groups/:group_id/ban/:user_id" => 'groups#ban_user'
  post "/places/results" => "places#results"
  get "/places/check_db/:lat/:lng/:pos" => "places#check_db"
  get "/groups/banned" => 'groups#banned', :as => :banned_from_group
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
  
  post "/users/:id/text" => 'users#text', :as => :text
  
  root :to => 'pages#home'
  
end
