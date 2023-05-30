Rails.application.routes.draw do
  require 'sidekiq/web'

  BookStoreBackend::Application.routes.draw do
    # mount Sidekiq::Web in your Rails app
    mount Sidekiq::Web => "/sidekiq"
  end

  resources :users
  resources :books 
  resources :orders
  post 'user/checkout', to: 'users#checkout'
  delete 'user/delete_order', to: 'books#delete_order'
  post 'user/update_order', to: 'books#update_order'
  get 'users/:id/orders', to: 'users#get_order_history'
  post 'books/add_to_cart', to: 'books#add_to_cart'
  get 'users/:id/cart', to: 'users#get_cart'
  post 'auth/login', to: 'authentication#login'
  get 'auth/logout', to: 'authentication#logout'
end
