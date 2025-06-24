# app/controllers/impersonations_controller.rb
class ImpersonationsController < ApplicationController
    before_action -> { authorize! :manage, User }

    def create
      user_to_impersonate = User.find(params[:id])
      impersonate(user_to_impersonate)
      render json: { message: "Now impersonating #{user_to_impersonate.email}" }
    end

    def destroy
      stop_impersonating
      render json: { message: "Stopped impersonation" }
    end
end
