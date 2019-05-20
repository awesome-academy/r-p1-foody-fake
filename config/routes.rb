Rails.application.routes.draw do

  root "static_page#home"

  get "/help", to: "static_page#help"
  get "/about", to: "static_page#about"
  get "/contact", to: "static_page#contact"
  get "/contact", to: "static_page#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  delete "/deletefood", to: "manager/foods#destroy"
  delete "/deleterestaurant", to: "admin/restaurants#destroy"
  delete "/deleteuser", to: "admin/users#destroy"
  get "/searchrestaurant", to: "restaurants#search"
  get "/mycart", to: "order_details#index"
  delete "/unlike_comment", to: "comment_likes#destroy"
  delete "/deleteuser", to: "admin/users#destroy"

  resources :restaurants
  resources :users
  resources :foods
  resources :ratings
  resources :comments
  resources :comment_likes
  resources :order_details
  resources :orders

  namespace :admin do
    resources :admins
    resources :users
    resources :restaurants
  end

  namespace :manager do
    resources :managers
    resources :foods
  end
end
