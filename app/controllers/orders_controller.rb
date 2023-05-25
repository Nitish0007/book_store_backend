class OrdersController < ApplicationController
    def index
        @orders = Order.all
        render json: @orders, status: :ok
    end
    def create
        
    end
end
