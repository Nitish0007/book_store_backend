class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:index, :create, :show]
    before_action :set_user, only: [:show, :destroy, :get_cart, :get_order_list]

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
        token = jwt_encode(user_id: @user.id)
        if create_dependencies
            render json: {user: @user, token: token}, status: :ok
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
        cart = @user.cart
        render json: cart, status: :ok
    end

    def get_order_list
        order_list = @user.order_list
        render json: order_list, status: :ok
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

    def create_dependencies
        @cart = Cart.new(user_id: @user.id)
        @cart.save
        @order_list = OrderList.new(user_id: @user.id)
        @order_list.save
    end
end
