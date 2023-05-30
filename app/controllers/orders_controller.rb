class OrdersController < ApplicationController
    
    def index
        @orders = Order.all
        render json: @orders, status: :ok
    end

    def destroy
        order = Order.find(params[:id])
        if order.destroy!
            render json: {message: 'order delete successfully'}, status: :ok
        end
    end

end
