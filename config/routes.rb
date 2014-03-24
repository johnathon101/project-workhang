ProjectWorkhang::Application.routes.draw do
  get "/" => 'pages#home', :as => :home
  get "/checkin/:id" => 'pages#checkin', :as => :checkin
  get "/about" => 'pages#about', :as => :about
  get "/checkout/:id" => 'pages#checkout', :as => :checkout
  get "/logout" => 'pages#logout', as => :logout
  post "/logins" => 'logins#create'
  delete "/logins/:id" => 'logins#destroy'
  resources :users
  resources :groups
  resources :places
end
