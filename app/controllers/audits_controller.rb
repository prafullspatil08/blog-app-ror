# app/controllers/audits_controller.rb
class AuditsController < ApplicationController
    before_action -> { authorize! :read, Audited::Audit }

    def index
      render json: Audited::Audit.order(created_at: :desc).limit(100)
    end
end
