# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action -> { authorize! :manage, User }

    def index
      render json: User.select(:id, :email, :role)
    end

    def update
      user = User.find(params[:id])
      if user.update(role_params)
        render json: { message: "Role updated", user: user.slice(:id, :email, :role) }
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def role_params
      params.require(:user).permit(:role)
    end
end
