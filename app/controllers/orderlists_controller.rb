class OrderlistsController < ApplicationController
    before_action :set_order_list, only: [:show, :delete]

    def index
        @order_lists = OrderList.all
        render json: @order_lists
    end

    def create
        @order_list = OrderList.new
        if @order_list.save
            render json: {message: 'order list create'}, status: :ok
        end
    end

    def show
        render json: @order_list, status: :ok
    end

    def update

    end

    def destroy
        
    end

    protected
    def set_order_list
        @order_list = OrderList.find(params[:order_list_id])
    end
end
