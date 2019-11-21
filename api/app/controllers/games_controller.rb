class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :update, :destroy, :get_participants, 
                                  :create_participants, :delete_participants]

  # GET /games
  def index
    params[:radius] = 10 unless params[:radius].present?
    errors = Validations.validate_search_by_distance(params[:latitude], 
                                                     params[:longitude],
                                                     params[:radius])
    unless errors.empty?
      @games = Game.all
      render json: format_response(payload: @games), status: :ok
      # render json: format_response(errors: errors), status: :bad_request
    else
      @games = Game.search_by_distance(params[:latitude], params[:longitude], params[:radius])
      render json: format_response(payload: @games), status: :ok
    end
  end

  # GET /games/:id
  def show
    render json: format_response(payload: @game), status: :ok
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.owner_user_login = current_user.login

    if @game.save
      Feed.new_feed(:create_game, current_user.login, {game_id: @game.id})
      render json: format_response(payload: @game), status: :created
    else
      render json: format_response(errors: @game.errors.full_messages), status: :bad_request
    end
  end

  # PATCH/PUT /games/:id
  def update
    if current_user.login != @game.owner
      return forbidden_request
    end
    
    if @game.update(game_params)
      render json: format_response(payload: @game), status: :ok
    else
      render json: format_response(errors: @game.errors.full_messages), status: :bad_request
    end
  end

  # DELETE /games/:id
  def destroy
    if current_user.login != @game.owner
      return forbidden_request
    end

    @game.destroy
    render json: format_response, status: :ok
  end

  # GET /games/:id/participants
  def get_participants
    participants = GameParticipant.where(game_id: @game.id, will_go: true)
    participants = participants.collect do |participant|
      user = User.find_by_login(participant.user_login)
      {
        login: user.login, name: user.name, 
        avatar: user.avatar, level: user.level, 
        joined_date: participant.joined_date,
      }
    end
    render json: format_response(payload: participants), status: :ok
  end

  # POST /games/:id/participants
  def create_participants
    if current_user.login == @game.owner
      return render json: format_response(errors: 49), status: :bad_request
    end
    
    participant = GameParticipant.new(game_id: @game.id, user_login: current_user.login, will_go: true)
    participant.save!
    Feed.new_feed(:join_game, current_user.login, {game_id: @game.id})
    get_participants
    rescue ActiveRecord::RecordNotUnique
      render json: format_response(errors: 49), status: :bad_request
  end

  # DELETE /games/:id/participants
  def delete_participants
    if current_user.login == @game.owner
      first = GameParticipant.find_by(game_id: @game.id, will_go: true)
      if first
        @game.update(owner_user_login: first.user_login)
        return get_participants
      else
        @game.destroy
        return render json: format_response(errors: 50), status: :ok
      end
    end

    participant = GameParticipant.find_by(game_id: @game.id, user_login: current_user.login)
    participant.destroy!
    get_participants
    rescue ActiveRecord::RecordNotFound
      render json: format_response(errors: 48), status: :not_found
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      game_id = params[:id].present? ? params[:id] : params[:game_id]
      @game = Game.find_by_id!(game_id)
      rescue ActiveRecord::RecordNotFound
        return not_found_request
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game).permit(:title, :description, :latitude, :longitude, :start_date, :end_date, :limit_participants)
    end
end
