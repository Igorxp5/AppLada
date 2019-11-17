class SocietiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_society, only: [:show, :update, :destroy, 
                                     :get_ratings, :create_ratings,:get_tournaments]

  # GET /societies
  def index
    params[:radius] = 10 unless params[:radius].present?
    errors = Validations.validate_search_by_distance(params[:latitude], 
                                                    params[:longitude],
                                                    params[:radius])
    unless errors.empty?
      render json: format_response(errors: errors), status: :bad_request
    else
      @societies = Society.search_by_distance(params[:latitude], params[:longitude], params[:radius])
      render json: format_response(payload: @societies), status: :ok
    end
  end

  # GET /societies/:id
  def show
    render json: format_response(payload: @society), status: :ok
  end

  # PATCH/PUT /societies/:id
  def update
    if current_user.login != @society.owner
      return forbidden_request
    end

    @society.phones = params[:phones] if params[:phones].present?
    if @society.update(society_params)
      render json: format_response(payload: @society), status: :ok
    else
      render json: format_response(errors: @society.errors.full_messages), status: :bad_request
    end
  end

  # GET /societies/:society_id/tournaments
  def get_tournaments
    @tournaments = @society.tournaments
    render json: format_response(payload: @tournaments), status: :ok
  end
  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_society
    society_id = params[:id].present? ? params[:id] : params[:society_id]
    @society = Society.find_by_id!(society_id)
    rescue ActiveRecord::RecordNotFound
      return not_found_request
  end

  def society_params
    params.fetch(:society).permit(:name, :description, :phones => [])
  end
end