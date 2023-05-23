class UsersController < ApplicationController
    include Rails.application.routes.url_helpers
    # skip_before_action :authenticate_request, only: [:index, :create, :show]
    before_action :set_user, only: [:show, :destroy]

    # before_action :authenticate_admin_request, only: [:index, :destroy, :update]

    # get method to fetch all the users from the database
    # route - {url}/users
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    # post method to create new user
    # route - {url}/users
    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: :ok
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


    private
    # setting user params 
    def user_params
        params.permit(:username, :email, :password, :is_admin)
    end

    # setting the current user before invokation of show and destroy methods
    def set_user
        @user = User.find(params[:id])
    end

    # def create_dependencies
    #     cart = Cart.create
    #     params[:cart_id] = cart.id
    #     order_list = OrderList.create
    #     params[:order_list_id] = order_list.id
    # end

    # def delete_dependencies
    #     # cart = Cart.find(params[:cart_id])
    #     # cart.destroy
    #     order_list = OrderList.find(@user.order_list_id)
    #     order_list.destroy
    # end
end
