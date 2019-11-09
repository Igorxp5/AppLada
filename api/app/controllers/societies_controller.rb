class SocietiesController < ApplicationController
    before_action :authenticate_user!
    before_action :search_params, only: :index

    def index
        @societies = Society.search_by_distance(params[:latitude].to_f, 
                                                params[:longitude].to_f,
                                                params[:radius].to_i)
        render json: format_response(payload: @societies), status: :ok
    end

    def search_params
        conditions = [
            [(params[:latitude].present? and params[:longitude].present?), 17],
            [(not params[:radius].present? or params[:radius].to_f <= 10), 17]
        ]
        validate_conditions(conditions)
    end
end