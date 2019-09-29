class LoginController < ApplicationController
	before_action :validate_params

	def auth
		@user = User.find_by_login(params[:login])
		if @user&.authenticate(params[:password])
			token = JsonWebToken.encode(user_id: @user.id)
			expiration_time = JsonWebToken.EXPIRATION_TIME
			payload = { token: token, expiration_time: expiration_time }
			render json: format_response(payload: payload), status: :ok
		else
			unauthorized_request(18)
		end
	end

	def login_params
		params.permit(:login, :password)
	end

	def validate_params
		conditions = [
			params[:login].present?,
			params[:password].present?,
			params[:login].instance_of?(String),
			params[:password].instance_of?(String)
		]
		unless conditions.all?
			render json: format_response(errors: ErrorCodes.get_error_message(17)), status: :bad_request 
		end
	end
end
