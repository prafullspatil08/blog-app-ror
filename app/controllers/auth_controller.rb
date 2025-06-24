# app/controllers/auth_controller.rb
class AuthController < ApplicationController
    # Skip authentication for login action
    skip_before_action :authenticate_user!

    def test
      render json: { message: "Test successful" }, status: :ok
    end

    def login
      user = User.find_by(email: params[:email])
      if user&.valid_password?(params[:password])
        token = JsonWebToken.encode(user_id: user.id)
        render json: { token:, role: user.role }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end

    def create
      user = User.new(user_params)

      if user.save
        token = JsonWebToken.encode(user_id: user.id)
        render json: {
          message: "User created successfully",
          success: true
        }, status: :created
      else
        render json: {
          message: "User creation failed",
          errors: user.errors.full_messages
        }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      permitted = params.require(:user).permit(:email, :password, :password_confirmation, :role)
      permitted[:role] = "viewer" unless current_user&.admin?
      permitted
    end
end
