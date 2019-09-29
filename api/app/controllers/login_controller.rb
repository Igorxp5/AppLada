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
		# Conditions to test and error code if not pass
		conditions = [
			[params[:login].present?, 4],
			[params[:password].present?, 8],
			[params[:login].instance_of?(String), 17],
			[params[:password].instance_of?(String), 17]
		]
		errors = conditions.collect { |condition| ErrorCodes.get_error_message(condition[1]) unless condition[0] }
		errors = errors.uniq.compact
		unless errors.empty?
			render json: format_response(errors: errors), status: :bad_request
		end
	end
end
