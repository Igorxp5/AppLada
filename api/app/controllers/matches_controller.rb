class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tournament
  before_action :set_match, only: [:show, :update, :destroy]

  # GET /tournaments/:tournament_id/matches
  def index
    @matches = Match.where(tournament_id: @tournament.id).order(match_order: :asc)

    render json: format_response(payload: @matches), status: :ok
  end

  # GET /tournaments/:tournament_id/matches/:order
  def show
    render json: format_response(payload: @match), status: :ok
  end

  # POST /tournaments/:tournament_id/matches
  def create
    if current_user.login != @tournament.society.owner
      return forbidden_request
    end

    @match = Match.new(match_params)
    @match.tournament_id = @tournament.id
    @match.teams = params[:teams]

    @match.save!
    render json: format_response(payload: @match), status: :created
    rescue ArgumentError
      render json: format_response(errors: @match.errors.full_messages), status: :bad_request
  end

  # PATCH/PUT /tournaments/:tournament_id/matches/:order
  def update
    if current_user.login != @tournament.society.owner
      return forbidden_request
    end

    @match.teams = params[:teams] if params[:teams].present?
    @match.scoreboard = params[:scoreboard] if params[:scoreboard].present?
    @match.winner = params[:winner] if params[:winner].present?
    @match.looser = params[:looser] if params[:looser].present?
    @match.finished = params[:finished] if params[:finished].present?

    @match.update!(update_params)
    render json: format_response(payload: @match), status: :ok
    rescue ArgumentError
      render json: format_response(errors: @match.errors.full_messages), status: :bad_request
  end

  # DELETE /tournaments/:tournament_id/matches/:order
  def destroy
    if current_user.login != @tournament.society.owner
      return forbidden_request
    end

    @match.delete
    render json: format_response, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find_by!(tournament_id: @tournament.id, match_order: params[:order])

      rescue ActiveRecord::RecordNotFound
        return not_found_request
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find_by!(id: params[:tournament_id])

      rescue ActiveRecord::RecordNotFound
        return not_found_request
    end

    # Only allow a trusted parameter "white list" through.
    def match_params
      params.require(:match).permit(:start_date, :duration, :teams => [])
    end

    def update_params
      params.fetch(:match).permit(
        :start_date, :duration, :winner, :looser, :finished, :scoreboard =>[], :teams => []
      )
    end
end
