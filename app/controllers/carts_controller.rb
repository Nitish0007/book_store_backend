class CartsController < ApplicationController
    before_action :cart_params

    def index
        @carts = Cart.all
        render json: @carts, status: :ok
    end

    def create
    end

    def show
    end

    def update
    end

    def destroy
    end

    protected
    def cart_params
        params.permit(:user_id)
    end



end
