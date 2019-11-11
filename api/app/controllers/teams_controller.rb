class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy, :get_members, :delete_members, :get_roles, :update_roles]
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

  # GET /teams/:initials
  def show
    render json: format_response(payload: @team), status: :ok
  end

  # POST /teams/:initials
  def create
    @team = Team.new(create_params)
    @team.owner = current_user.login

    if @team.save
      render json: format_response(payload: @team), status: :created
    else
      render json: format_response(errors: @team.errors.full_messages), status: :bad_request
    end
  end

  # PATCH/PUT /teams/:initials
  def update
    if current_user.login != @team.owner
      return forbidden_request
    end
      
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teams/:initials
  def destroy
    if current_user.login != @team.owner
      return forbidden_request
    end

    @team.destroy
    render json: format_response, status: :ok
  end
  # GET /teams/:initials/members
  def get_members
    @members = @team.members
    users = @members.collect do |member|
      if member == @team.owner
        joined_date = @team.created_date
      
      else 
        subscription = TeamSubscription.find_by(team_initials: @team.initials, user_login: member)
        joined_date = subscription.joined_date

      end
      user = User.find_by_login(member)
      {login: user.login, name: user.name, avatar: user.avatar, joined_date: joined_date}
    end
    render json: format_response(payload: users), status: :ok
  end 
    

  # DELETE /teams/:initials/members
  def delete_members
    if current_user.login != @team.owner
      return forbidden_request
    end
    
    subscription = TeamSubscription.find_by!(team_initials: @team.initials, user_login: params[:login])

    subscription.destroy
    render json: format_response, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: format_response(errors: 37), status: :bad_request

  end

  # GET /teams/1/roles
  def get_roles
    @members = @team.members
    users = @members.collect do |member|
    subscription = TeamSubscription.find_by(team_initials: @team.initials, user_login: member)
    {login: subscription.user_login, role: subscription.role}
    end

    render json: format_response(payload: users), status: :ok

  end

  # PUT /teams/1/roles
  def update_roles
    if current_user.login != @team.owner
      return forbidden_request
    end

    members = JSON.parse(request.body.read)
    members.collect do |member, value|
      subscription = TeamSubscription.find_by(team_initials: @team.initials, user_login: member)
      if not subscription
        return render json: format_response(errors: 39), status: :bad_request
      end
      subscription.update(role: value)
    end
   
    render json: format_response, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      if params[:initials] 
        @team = Team.find_by!("lower(initials) = ?", params[:initials].downcase)
      else
        @team = Team.find_by!("lower(initials) = ?", params[:team_initials].downcase)

      end
      
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