class AuthenticationController < ApplicationController
    # skip_before_action :authenticate_request


    # post request , /auth/login
    def login
        @user = User.find_by_email(params[:email])
        if @user.blank?
            render json: {message: 'User does not exits'}, status: :unprocessable_entity
        elsif @user.authenticate(params[:password])
            token = jwt_encode(user_id: @user.id)
            render json: {token: token}, status: :ok
        else
            render json: {message: 'unauthorized'}, status: :unauthorized
        end
    end

    

    protected
    def login_params 
        params.require(:email, :password)
    end

end
