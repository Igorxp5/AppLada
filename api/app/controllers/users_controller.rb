class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user

	# GET /users/:login
	def show
		render json: format_response(payload: @user), status: :ok
	end
end
