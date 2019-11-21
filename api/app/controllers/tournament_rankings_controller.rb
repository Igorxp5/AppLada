class TournamentRankingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tournament

    def index
        @ranking = TournamentRanking.tournament_ranking(@tournament.id)
        render json: format_response(payload: @ranking), status: :ok
    end

    def create
        if current_user.login != @tournament.society.owner
            return forbidden_request
        end
        TournamentRanking.set_tournament_ranking(@tournament.id, params[:ranking])
        index
    end

    def update
        if current_user.login != @tournament.society.owner
            return forbidden_request
        end
        TournamentRanking.set_tournament_ranking(@tournament.id, params[:ranking])
        index
    end

    def destroy
        if current_user.login != @tournament.society.owner
            return forbidden_request
        end
        TournamentRanking.delete_tournament_ranking(@tournament.id)
        render json: format_response, status: :ok
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
        @tournament = Tournament.find_by!(id: params[:tournament_id])
        rescue ActiveRecord::RecordNotFound
            return not_found_request
    end
end