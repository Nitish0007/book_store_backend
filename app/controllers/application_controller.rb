class ApplicationController < ActionController::API
    include JsonWebToken

    before_action :authenticate_request


    private
    def authenticate_request
        header = request.headers["Authorization"]
        header = header.split(" ")[1] if header
        begin
            decoded = jwt_decode(header)
            is_token_invalid = Jti.exists?(key: decoded[:jti])
            if is_token_invalid
                render json: {message: 'Invalid Token'}, status: :unprocessable_entity
            else
                @current_user = User.find(decoded[:user_id])
                @jti = decoded[:jti]
            end
        rescue ActiveRecord::RecordNotFound => e
            render json: {message: e.message}, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: {message: e.message}, status: :unauthorized
        end
    end


end
