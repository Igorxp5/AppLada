class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy, :get_members, :delete_members, :get_roles, :update_roles, :accept_invite, :refuse_invite, :get_requests, :create_requests, :delete_requests, :statistics]
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

  # POST /teams
  def create
    @team = Team.new(create_params)
    @team.owner = current_user.login

    if @team.save
      Feed.new_feed(:create_team, current_user.login, {team_initials: @team.initials})
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
    if current_user.login == @team.owner
        
      subscription = TeamSubscription.find_by!(team_initials: @team.initials, user_login: params[:login])
      Feed.new_feed(:leave_team, current_user.login, {team_initials: @team.initials})
      subscription.destroy
      
      render json: format_response, status: :ok 
    else
      return forbidden_request
    end
 
    rescue ActiveRecord::RecordNotFound
      render json: format_response(errors: 37), status: :bad_request

  end

  # GET /teams/:initials/roles
  def get_roles
    @members = @team.members
    users = @members.collect do |member|
    subscription = TeamSubscription.find_by(team_initials: @team.initials, user_login: member)
    {login: subscription.user_login, role: subscription.role}
    end

    render json: format_response(payload: users), status: :ok

  end

  # PUT /teams/:initials/roles
  def update_roles
    if current_user.login != @team.owner
      return forbidden_request
    end

    members = JSON.parse(request.body.read)
    members.collect do |member, value|
      subscription = TeamSubscription.find_by(team_initials: @team.initials, user_login: member)
      unless subscription
        return render json: format_response(errors: 52), status: :bad_request
      end
      subscription.update(role: value)
    end
   
    render json: format_response, status: :ok
  end

  # GET /invites
  def get_invites
    invites = TeamSubscription.where(user_login: current_user.login, accepted: nil)
                                      .offset(params[:offset]).limit(params[:limit])
    render json: format_response(payload: invites), status: :ok
  end                            

  # PUT /invites/:initials
  def accept_invite 
    invite = TeamSubscription.find_by(team_initials: @team.initials, user_login: current_user.login, accepted: nil)
    unless invite
      return render json: format_response(errors: 53), status: :bad_request
    end
    invite.update(accepted: true)
    Feed.new_feed(:join_team, current_user.login, {team_initials: @team.initials})
    render json: format_response(payload: invite), status: :ok
    

  end

  # DELETE /invites/:initials
  def refuse_invite 
    invite = TeamSubscription.find_by(team_initials: @team.initials, user_login: current_user.login, accepted: nil)
    unless invite
      return render json: format_response(errors: 53), status: :bad_request
    end
    invite.update(accepted: false)
    render json: format_response(payload: invite), status: :ok
    
  end

  # GET /teams/:initials/requests
  def get_requests
    invites = TeamSubscription.where(team_initials: @team.initials)
                                      .offset(params[:offset]).limit(params[:limit])
    
    invites = invites.select do |subscription|
      @team.owner != subscription.user_login

    end
    
    render json: format_response(payload: invites), status: :ok 
  end

  # POST /teams/:initials/requests
  def create_requests
    if current_user.login != @team.owner
      return forbidden_request
    end

    user = User.find_by(login: params[:login])
    if user.nil?
      return render json: format_response(errors: 27), status: :bad_request
    end

    current_request = TeamSubscription.find_by(team_initials: @team.initials, user_login: params[:login])
    if current_request
      if current_request.accepted
        return render json: format_response(errors: 54), status: :bad_request
      else
        current_request.destroy
      end
    end

    request = TeamSubscription.new(team_initials: @team.initials, user_login: params[:login])
    if request.save
      render json: format_response(payload: request), status: :created
    else
      render json: format_response(errors: 0), status: :bad_request
    end
  end

  # DELETE /teams/:initials/requests
  def delete_requests
    if current_user.login != @team.owner
      return forbidden_request
    end

    current_request = TeamSubscription.find_by(team_initials: @team.initials, user_login: params[:login])
    if current_request
      if current_request.accepted 
        return render json: format_response(errors: 54), status: :bad_request
      end

      current_request.update(accepted: false)
      render json: format_response(payload: current_request), status: :ok
    else
      return not_found_request
    end
  end

  # GET /teams/:initials/statistics
  def statistics
    payload = {
			total_played_matches: @team.total_played_matches,
			total_win_matches: @team.total_win_matches,
			total_played_tournaments: @team.total_played_tournaments,
			total_win_tournaments: @team.total_win_tournaments,
			last_played_tournament: @team.last_played_tournament
		}
		render json: format_response(payload: payload), status: :ok
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
