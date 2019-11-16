class TournamentSubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tournament_subscription, only: [:show, :update, :destroy]

  # GET /tournament_subscriptions
  def index
    @tournament_subscriptions = TournamentSubscription.all

    render json: @tournament_subscriptions
  end

  # GET /tournament_subscriptions/1
  def show
    render json: @tournament_subscription
  end

  # POST /tournament_subscriptions
  def create
    @tournament_subscription = TournamentSubscription.new(tournament_subscription_params)

    if @tournament_subscription.save
      render json: @tournament_subscription, status: :created, location: @tournament_subscription
    else
      render json: @tournament_subscription.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tournament_subscriptions/1
  def update
    if @tournament_subscription.update(tournament_subscription_params)
      render json: @tournament_subscription
    else
      render json: @tournament_subscription.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tournament_subscriptions/1
  def destroy
    @tournament_subscription.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament_subscription
      @tournament_subscription = TournamentSubscription.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tournament_subscription_params
      params.require(:tournament_subscription).permit(:subscription, :tournament_id, :team_initials, :accepted, :banned, :joined_date)
    end
end
