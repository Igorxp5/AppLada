class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :find_user

	# GET /users/:login
	def show
		render json: format_response(payload: @user), status: :ok
	end

	private

	def find_user
		@user = User.find_by_login!(params[:login])
		rescue ActiveRecord::RecordNotFound
			render json: format_response(), status: :not_found
	end
end
