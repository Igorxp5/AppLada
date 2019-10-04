class UserController < ApplicationController
	before_action :find_user

	# GET /users/:username
	def show
		render json: @user, status: :ok
	end

	private

	def find_user
		@user = User.find_by_username!(params[:login])
		rescue ActiveRecord::RecordNotFound
			render json: { errors: 'User not found' }, status: :not_found
	end
end
