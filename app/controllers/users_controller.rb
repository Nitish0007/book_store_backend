class UsersController < ApplicationController

    require 'securerandom'

    skip_before_action :authenticate_request, only: [:index, :create, :show]
    before_action :set_user, only: [:show, :destroy, :get_cart, :get_order_history]

    
    # get method to fetch all the users from the database
    # route - {url}/users
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    # post method to create new user
    # route - {url}/users
    def create
        @user = User.create(user_params)
        if @user.valid?
            render json: {user: @user}, status: :ok
        else
            render json: {message: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    # get method to get particular user 
    # route - {url}/users/:id
    def show
            render json: @user, status: :ok
    end

    # put method to update user data
    def update
        if @user.update(user_params)
            render json: {message: "User Updated successfully"}, status: :ok
        else
            render json: {message: @user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    # delete method to delete user from the table
    def destroy
        if @user.destroy
            render json: {message: 'User deleted from the database'}, status: :ok
        end
    end

    def get_cart
        @cart = Order.where(user_id: @current_user.id, placed: false)
        if @cart
            render json: @cart, status: :ok
        else
            render json: {message: @cart.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def checkout
        cart = Order.where(user_id: @current_user.id, placed: false)
        cart_data = cart.to_a
        if cart.update_all(placed: true)
            SendEmailWorkerJob.perform_async(@current_user.id, cart_data.to_json)
            render json: {message: 'order placed successfully'}, status: :ok
        end
    end

    def get_order_history
        order_history = Order.select do |order|
            (order.user_id = @user.id) && (order.placed == true)
        end
        if order_history
            render json: order_history, status: :ok
        else
            render json: {message: order_history.errors.full_messages}, status: :unprocessable_entity
        end
    end


    private
    # setting user params 
    def user_params
        jti_key = SecureRandom.uuid()
        params[:jti_key] = jti_key
        params.permit(:username, :email, :password, :is_admin, :jti_key)
    end

    # setting the current user before invokation of show and destroy methods
    def set_user
        @user = User.find(params[:id])
    end

end
