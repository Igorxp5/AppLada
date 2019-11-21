class TournamentTeamsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tournament
    before_action :set_team, only: [:destroy]
    before_action :set_tournament_subscription, only: [:destroy]

    # GET /tournaments/:tournament_id/teams
    def index
        subscriptions = TournamentSubscription.where(tournament_id: @tournament.id, accepted: true)
        @teams = subscriptions.collect do |subscription|
            team = Team.find_by_initials(subscription.team_initials)
            {
                initials: team.initials, name: team.name, 
                avatar: team.avatar, joined_date: subscription.joined_date
            }
        end 
        render json: format_response(payload: @teams), status: :ok
    end

    # DELETE /tournaments/:tournament_id/teams/:team_initials
    def destroy
        if current_user.login != @tournament.society.owner
            return forbidden_request
        end
        @subscription.delete
        render json: format_response, status: :ok
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
        @tournament = Tournament.find_by!(id: params[:tournament_id])
  
        rescue ActiveRecord::RecordNotFound
          return not_found_request
    end

    def set_tournament_subscription
        @subscription = TournamentSubscription.find_by(tournament_id: @tournament.id, team_initials: @team.initials)
        if @subscription.nil?
          return render json: format_response(errors: 73), status: :bad_request
        end
    end

    def set_team
        @team = Team.find_by_initials(params[:team_initials])
        if @team.nil?
            return render json: format_response(errors: 71), status: :bad_request
        end
    end
end