class ApplicationController < ActionController::API
    include JsonWebToken

    before_action :authenticate_request


    private
    def authenticate_request
        header = request.headers["Authorization"]
        header = header.split(" ")[1] if header
        begin
            decoded = jwt_decode(header)
            current_user = User.find(decoded[:user_id])
            if current_user.jti_key == decoded[:jti_key]
                @current_user = current_user
            else
                render json: {message: 'Invalid Token'}, status: :unprocessable_entity
            end
        rescue ActiveRecord::RecordNotFound => e
            render json: {message: e.message}, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: {message: e.message}, status: :unauthorized
        end
    end


end
