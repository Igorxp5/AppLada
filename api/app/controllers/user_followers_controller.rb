class UserFollowersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  # GET /users/:login/followers
  def followers
    @followers = UserFollower.where(user_login: params[:user_login])
                            .order(follower_user_login: :asc)
    users = @followers.collect do |follower|
      user = User.find_by_login(follower.follower_user_login)
      {login: user.login, name: user.name, level: user.level, avatar: user.avatar}
    end
    render json: format_response(payload: users), status: :ok
  end

  # OPTIONS /users/:login/followers
  # Check if current user is already following the user
  def options
    if current_user.login == params[:user_login]
      response.set_header('Allow', 'OPTIONS, GET')
    else
      @user_follower = UserFollower.find_by(user_login: params[:user_login],
                                          follower_user_login: current_user.login)
      if @user_follower.nil?
        response.set_header('Allow', 'OPTIONS, GET, POST')
      else
        response.set_header('Allow', 'OPTIONS, GET, DELETE')
      end
    end
    render nothing: true, status: :ok
  end

  # GET /users/:login/following
  def followings
    @followings = UserFollower.where(follower_user_login: params[:user_login])
                            .order(user_login: :asc)
    users = @followings.collect do |following|
      user = User.find_by_login(following.user_login)
      {login: user.login, name: user.name, level: user.level, avatar: user.avatar}
    end
    render json: format_response(payload: users), status: :ok
  end

  # POST /users/:login/followers
  def create
    if current_user.login == params[:user_login]
      return render json: format_response(errors: 31), status: :bad_request
    end
    
    @user_follower = UserFollower.new(user_login: params[:user_login], 
                                      follower_user_login: current_user.login)
    if @user_follower.save
      render json: format_response, status: :created
    else
      render json: format_response(errors: 0), status: :bad_request
    end
    rescue ActiveRecord::RecordNotUnique
      render json: format_response(errors: 29), status: :bad_request
  end

  # /users/:login/followers
  def destroy
    if current_user.login == params[:user_login]
      return render json: format_response(errors: 31), status: :bad_request
    end

    @user_follower = UserFollower.find_by!(user_login: params[:user_login],
                                           follower_user_login: current_user.login)
    @user_follower.destroy
    render json: format_response, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: format_response(errors: 30), status: :not_found
  end

end
