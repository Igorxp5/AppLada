class TournamentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tournament, only: [:show, :update, :destroy]

  # GET /tournaments
  def index
    @tournaments = Tournament.all

    render json: @tournaments
  end

  # GET /tournaments
  def index
    params[:radius] = 10 unless params[:radius].present?
    errors = Validations.validate_search_by_distance(params[:latitude], 
                                                     params[:longitude],
                                                     params[:radius])
    unless errors.empty?
      render json: format_response(errors: errors), status: :bad_request
    else
      @tournaments = Tournament.search_by_distance(params[:latitude], params[:longitude], params[:radius])
      render json: format_response(payload: @tournaments), status: :ok
    end
  end

  # GET /tournaments/:tournament_id
  def show
    render json: format_response(payload: @tournament), status: :ok
  end

  # POST /tournaments
  def create
    unless params[:society_id].present?
      return render json: format_response(errors: 60), status: :bad_request
    end
    
    society = Society.find_by_id(params[:society_id])
    if society.nil?
      return render json: format_response(errors: 61), status: :bad_request
    end

    if current_user.login != society.owner
      return forbidden_request
    end
    
    @tournament = Tournament.new(create_params)

    if @tournament.save
      render json: format_response(payload: @tournament), status: :created
    else
      render json: format_response(errors: @tournament.errors.full_messages), status: :bad_request
    end

    rescue ActiveRecord::RecordNotUnique
      render json: format_response(errors: 69), status: :bad_request
  end


  # PATCH/PUT /tournaments/:tournament_id
  def update
    if current_user.login != @tournament.society.owner
      return forbidden_request
    end
    
    if @tournament.update(update_params)
      render json: format_response(payload: @tournament), status: :ok
    else
      render json: format_response(errors: @tournament.errors.full_messages), status: :bad_request
    end
  end

  # DELETE /tournaments/:tournament_id
  def destroy
    if current_user.login != @tournament.society.owner
      return forbidden_request
    end

    @tournament.destroy
    render json: format_response, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find_by!(id: params[:tournament_id])

      rescue ActiveRecord::RecordNotFound
        return not_found_request
    end

    # Only allow a trusted parameter "white list" through.
    def create_params
      params.require(:tournament).permit(:id, :society_id, :title, :description, :start_date, :end_date, :end_subscription_date, :price, :teams_limit)
    end

    def update_params
      params.require(:tournament).permit(:id, :title, :description, :start_date, :end_date, :end_subscription_date, :price, :teams_limit)
    end
end
