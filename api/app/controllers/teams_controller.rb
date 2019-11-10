class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :validate_limit, only: [:index]
 

  # GET /teams
  def index
    if params[:name].present?
      @teams = Team.where("lower(name) like lower(:name)", {name: "%#{params[:name]}%"}).offset(params[:offset]).limit(params[:limit]).order(name: :asc)

    else
      @teams = Team.all.offset(params[:offset]).limit(params[:limit]).order(name: :asc)

    end
    @teams = @teams.collect do |team|
      {initials: team.initials, name: team.name, avatar: team.avatar,owner: team.owner, members: team.members}
    end
    render json: format_response(payload: @teams), status: :ok
  end

  # GET /teams/1
  def show
    render json: format_response(payload: @team), status: :ok
  end

  # POST /teams
  def create
    
    @team = Team.new(create_params)
    @team.owner = current_user.login

    if @team.save
      render json: format_response, status: :created
    else
      render json: format_response(errors: @team.errors.full_messages), status: :bad_request
    end


  end

  # PATCH/PUT /teams/1
  def update
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teams/1
  def destroy
    if current_user.login != @team.owner
      return forbidden_request
    end

    @team.destroy
    render json: format_response, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find_by!("lower(initials) = ?", params[:initials].downcase)
      rescue ActiveRecord::RecordNotFound
        return not_found_request
    end

    # Only allow a trusted parameter "white list" through.
    def team_params
      params.require(:team).permit(:initials, :name, :avatar, :owner)
    end

    def create_params
      params.require(:team).permit(:initials, :name, :avatar)
    end


end
