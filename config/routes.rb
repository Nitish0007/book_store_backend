Rails.application.routes.draw do
  
  resources :users
  resources :books
  resources :orderlists
  resources :orders
  post 'books/add_to_cart', to: 'books#add_to_cart'
  get 'users/:id/cart', to: 'users#get_cart'
  get 'users/:id/order_list', to: 'users#get_order_list'
  post '/auth/login', to: 'authentication#login'

end
