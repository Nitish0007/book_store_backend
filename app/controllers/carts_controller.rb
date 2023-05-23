class CartsController < ApplicationController
    def index

    end

    def create
        @cart = Cart.new
        if @cart.save
            render json: {message: 'cart created'}, status: :ok
        end
    end

    def show
        
    end

    def update

    end

    def destroy

    end
end
