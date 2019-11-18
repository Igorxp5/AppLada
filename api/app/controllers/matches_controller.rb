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
    
    # Adicionar feed para todos os jogadores dos times envolvidos
    add_team_match_feed(params[:teams][0], :will_play_match_tournament)
    add_team_match_feed(params[:teams][1], :will_play_match_tournament)
    
    render json: format_response(payload: @match), status: :created
  rescue ArgumentError, ActiveRecord::RecordInvalid
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

    if @match.finished
        add_finished_match_feed
    end

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

    def add_team_match_feed(team_initials, feed_type)
      team = (@match.teams.select {|team| team.initials == team_initials})[0]
      index_team = @match.teams.index(team)
      against_team = @match.teams[index_team - 1]
      team.members.each do |user_login|
        arguments = {
          tournament_id: @tournament.id, user_team_initials: team.initials,
          against_team_initials: against_team.initials, match_order: @match.match_order
        }
        Feed.new_feed(feed_type, user_login, arguments)
      end
    end

    def add_finished_match_feed
      if @match.draw?
        team_one = @match.teams[0]
        team_two = @match.teams[1]
        add_team_match_feed(team_one.initials, :draw_match_tournament)
        add_team_match_feed(team_two.initials, :draw_match_tournament)
      else
        add_team_match_feed(@match.winner, :win_match_tournament)
        add_team_match_feed(@match.looser, :lose_match_tournament)
      end
    end
end
