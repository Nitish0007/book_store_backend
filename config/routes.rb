Rails.application.routes.draw do
  
  resources :users
  resources :books
  resources :carts
  resources :orderlists
  post '/auth/login', to: 'authentication#login'

end
