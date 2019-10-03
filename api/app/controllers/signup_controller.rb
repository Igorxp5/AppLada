class SignupController < ApplicationController

	def create
		begin
			@user = User.new(user_params)
			if @user.save
				result = {login: @user.login, password: params[:password]}
				render json: format_response(payload: result), status: :created
			else
				render json: format_response(errors: @user.errors.full_messages), status: :bad_request
			end
		end
	end

	private

	def user_params
	    params.permit(
	      :login, :password, :name, :email, :gender, :birthday
	    )
  	end
end
