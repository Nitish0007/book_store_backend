class ApplicationController < ActionController::API
    include JsonWebToken

    # before_action :authenticate_request

    private
    def authenticate_request
        header = request.headers["Authorization"]
        header = header.split(" ").last if header
        begin
            decoded = jwt_decode(header)
            @current_user = User.find(decode[:user_id])
        rescue ActiveRecord::RecordNotFound => e
            render json: {message: e.message}, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: {message: e.message}, status: :unauthorized
        end
    end

    # def authenticate_admin_request
    #     potential_admin = User.find(params[:user_id])
    #     if potential_admin.nil?
    #         render json: {message: 'User not found'}, status: :unprocessable_entity
    #     elsif potential_admin.is_admin? 
    #         render json: { message: 'User has admin rights'}, status: :ok
    #     else
    #         render json: {message: 'User do not have admin rights'}, status: :unauthorized
    #     end
    # end

end
