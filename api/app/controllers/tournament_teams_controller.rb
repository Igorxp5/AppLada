class TournamentTeamsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tournament

    # GET /tournaments/:tournament_id/teams
    def index
        subscriptions = TeamSubscription.all
        @teams = subscriptions.collect do |subscription|
            subscription.team_initials
        end 
        render json: format_response(payload: @teams), status: :ok
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
        @tournament = Tournament.find_by!(id: params[:tournament_id])
  
        rescue ActiveRecord::RecordNotFound
          return not_found_request
    end
end