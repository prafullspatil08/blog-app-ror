class ApplicationController < ActionController::API
    include CanCan::ControllerAdditions
    attr_reader :current_user

    before_action :authenticate_user!

    def authenticate_user!
      token = request.headers["Authorization"]&.split(" ")&.last
      decoded = JsonWebToken.decode(token)
      @current_user = User.find_by(id: decoded[:user_id]) if decoded
      render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
    end

    rescue_from CanCan::AccessDenied do
      render json: { error: "Access denied" }, status: :forbidden
    end
end
