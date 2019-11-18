class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user
	before_action :validate_limit, only: [:feeds]

	# GET /users/:login
	def show
		render json: format_response(payload: @user), status: :ok
	end
	
	# GET /users/:login/games
	def games
		render json: format_response(payload: @user.games), status: :ok
	end

	# GET /users/:login/feeds
	def feeds
		@feeds = @user.feeds(params[:offset], params[:limit])
        render json: format_response(payload: @feeds), status: :ok
	end

	# GET /users/:login/teams
	def teams
		render json: format_response(payload: @user.teams), status: :ok
	end

	# DELETE /users/:login/teams/:initials
	def leave_team
		if current_user.login != @user.login
			return forbidden_request
		end

		teams_initials = @user.teams.collect do |team| team.initials end
		params[:initials] = params[:initials].upcase
		unless teams_initials.include?(params[:initials])
			return render json: format_response(errors: 71), status: :bad_request
		end

		subscription = TeamSubscription.find_by!(team_initials: params[:initials], user_login: current_user.login)									
		subscription.destroy
		Feed.new_feed(:leave_team, current_user.login, {team_initials: params[:initials])

		# change team owner
		team = Team.find_by(initials: params[:initials])
		if current_user.login == team.owner
			subscriptions = TeamSubscription.where(team_initials: params[:initials], accepted: true, banned: false).order(joined_date: :desc)
			team.update(owner: (subscriptions[0].user_login))
		end

		render json: format_response(payload: subscription), status: :ok 
		rescue ActiveRecord::RecordNotFound
			render json: format_response(errors: 37), status: :bad_request
	end
	# GET /users/:login/societies
	def societies
    	render json: format_response(payload: @user.societies), status: :ok
	end

	# GET /users/:login/statistics
	def statistics
		payload = {
			total_played_tournaments: @user.total_played_tournaments,
			total_win_tournaments: @user.total_win_tournaments,
			last_played_tournament: @user.last_played_tournament,
			total_played_games: @user.games.size
		}
		render json: format_response(payload: payload), status: :ok
	end

end
