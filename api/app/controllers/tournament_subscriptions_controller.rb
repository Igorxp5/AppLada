class TournamentSubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :create, :destroy, :accept, :refuse]
  before_action :set_tournament, only: [:index, :show, :create, :destroy, :accept, :refuse]
  before_action :set_tournament_subscription, only: [:show, :destroy, :accept, :refuse]
  before_action :validate_status_param, only: [:index]

  # GET /tournaments/:id/requests
  def index
    if params[:status].present?
      @subscriptions = TournamentSubscription.where_by_status(tournament_id: @tournament.id, status: params[:status])
    else
      @subscriptions = TournamentSubscription.where(tournament_id: @tournament.id)
    end
    @subscriptions = @subscriptions.order(created_at: :desc)

    render json: format_response(payload: @subscriptions), status: :ok
  end

  # GET /tournaments/:id/tickets/:team_initials
  def show
    unless [@team.owner, @tournament.society.owner].include?(current_user.login)
      return forbidden_request
    end
    render json: format_response(payload: @subscription), status: :ok
  end

  # POST /tournaments/:id/tickets
  def create
    if current_user.login != @team.owner
      return forbidden_request
    end

    @tournament_subscription = TournamentSubscription.new(team_initials: @team.initials, tournament_id: @tournament.id)

    if @tournament_subscription.save
      render json: format_response(payload: @tournament_subscription), status: :created
    else
      render json: format_response(errors: @tournament_subscription.errors.full_messages), status: :bad_request
    end

    rescue ActiveRecord::RecordNotUnique
      render json: format_response(errors: 72), status: :bad_request
  end

  # DELETE /tournament_subscriptions/1
  def destroy
    if current_user.login != @team.owner
      return forbidden_request
    end
    
    @subscription.delete
    render json: format_response, status: :ok
  end

  # POST /tournaments/:id/requests/:team_initials
  def accept
    if current_user.login != @tournament.society.owner
      return forbidden_request
    end

    if @subscription.accepted
      return render json: format_response(errors: 75), status: :bad_request
    elsif not @subscription.accepted.nil?
      return render json: format_response(errors: 76), status: :bad_request
    end

    @subscription.accepted = true
    @subscription.save
    return render json: format_response(payload: @subscription), status: :ok
  end

  # DELETE /tournaments/:id/requests/:team_initials
  def refuse
    if current_user.login != @tournament.society.owner
      return forbidden_request
    end

    if @subscription.accepted
      return render json: format_response(errors: 75), status: :bad_request
    elsif not @subscription.accepted.nil?
      return render json: format_response(errors: 76), status: :bad_request
    end

    @subscription.accepted = false
    @subscription.save
    return render json: format_response(payload: @subscription), status: :ok
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tournament
      @tournament = Tournament.find_by!(id: params[:tournament_id])

      rescue ActiveRecord::RecordNotFound
        return not_found_request
  end

  def set_team
    @team = Team.find_by_initials(params[:team_initials])
    if @team.nil?
      return render json: format_response(errors: 71), status: :bad_request
    end
  end

  def set_tournament_subscription
    @subscription = TournamentSubscription.find_by(tournament_id: @tournament.id, team_initials: @team.initials)
    if @subscription.nil?
      return render json: format_response(errors: 73), status: :bad_request
    end
  end

  def validate_status_param
    if params[:status].present?
      params[:status] = params[:status].to_sym
      if not TournamentSubscription.STATUS.include?(params[:status])
        return render json: format_response(errors: 74), status: :bad_request
      end
    end
  end

end
