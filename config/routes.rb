Rails.application.routes.draw do
  
  resources :users
  resources :books
  resources :orderlists
  get 'users/:id/cart', to: 'users#get_cart'
  get 'users/:id/order_list', to: 'users#get_order_list'
  post '/auth/login', to: 'authentication#login'

end
