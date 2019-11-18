class SocietyRatingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_society
    before_action :set_rating, only: [:update, :destroy]
  
  # GET /societies/:id/ratings
  def index
    @ratings = SocietyRating.where(society_id: @society.id).order(updated_at: :desc)
    render json: format_response(payload: @ratings), status: :ok
  end

  # POST /societies/:id/ratings
  def create
    if current_user.login == @society.owner
      return render json: format_response(errors: 58), status: :bad_request
    end
    @rating = SocietyRating.new(rating_params)
    @rating.society_id = @society.id
    @rating.user_login = current_user.login
    @rating.save!
    render json: format_response(payload: @rating), status: :created
    rescue ActiveRecord::RecordNotUnique
      render json: format_response(errors: 59), status: :bad_request
  end

  # PATCH/PUT /societies/:id/ratings
  def update
    if @rating.update(rating_params)
      render json: format_response(payload: @rating), status: :ok
    else
      render json: format_response(errors: @rating.errors.full_messages), status: :bad_request
    end
  end

  # DELETE /societies/:id/ratings
  def destroy
    @rating.destroy
    render json: format_response, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_society
    society_id = params[:id].present? ? params[:id] : params[:society_id]
    @society = Society.find_by_id!(society_id)
    rescue ActiveRecord::RecordNotFound
      return not_found_request
  end

  def set_rating
    if current_user.login == @society.owner
      return render json: format_response(errors: 58), status: :bad_request
    end
    
    @rating = SocietyRating.find_by!(society_id: @society.id, user_login: current_user.login)
    puts "rating: #{@rating}"
    rescue ActiveRecord::RecordNotFound
      return not_found_request
  end

  def rating_params
    params.require(:society_rating).permit(:rating, :comment)
  end
end