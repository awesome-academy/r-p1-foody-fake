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
  get "/searchrestaurant", to: "admin/restaurants#search"
  get "/mycart", to: "order_details#index"
  delete "/unlike_comment", to: "comment_likes#destroy"
  delete "/deleteuser", to: "admin/users#destroy"
  delete "/deleteorder", to: "orders#destroy"
  get "/searchdistrict", to: "districts#search"
  get "/managerfoods", to: "manager/foods#index"
  get "/searchward", to: "wards#search"
  get "/searchrestaurantbylocation", to: "restaurants#search_by_location"
  get "/searchrestaurantnearme", to: "restaurants#search_near_me"
  get "/updatestatus", to: "orders#update_status"
  get "/getcomment", to: "comments#get_comment"
  post "/comments/:id", to: "comments#update"

  resources :restaurants
  resources :users
  resources :foods
  resources :ratings
  resources :comments
  resources :comment_likes
  resources :order_details
  resources :orders
  resources :districts

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
