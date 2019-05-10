Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_page#home"
  get "/about", to: "static_page#about"
  get "/contact", to: "static_page#contact"
  get "/contact", to: "static_page#contact"

end
