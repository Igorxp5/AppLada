class SessionsController < Devise::SessionsController
	before_action :validate_params, only: [:create]
	before_action :pass_params_to_user, only: [:create]

	respond_to :json
	
	def create
		self.resource = warden.authenticate(auth_options)
		if resource.nil?
			unauthorized_request(18)
		else
			sign_in(resource_name, resource)
			payload = {token: jwt_token}
			render json: format_response(payload: payload), status: :ok
		end
	end

	def respond_to_on_destroy
		head :no_content
	end

	private

	def pass_params_to_user
		request.params[:user] = ActiveSupport::HashWithIndifferentAccess.new(
			login: params[:login], email: params[:email], password: params[:password]
		)
	end

	def jwt_token
		request.env['warden-jwt_auth.token']
	end

	def validate_params
		# Conditions to test and error code if not pass
		conditions = [
			[(params[:login].present? or params[:email].present?), 28],
			[params[:password].present?, 8],
			[(params[:login].instance_of?(String) or params[:email].instance_of?(String)), 17],
			[params[:password].instance_of?(String), 17]
		]
		errors = conditions.collect { |condition| ErrorCodes.get_error_message(condition[1]) unless condition[0] }
		errors = errors.uniq.compact
		unless errors.empty?
			render json: format_response(errors: errors), status: :bad_request
		end
	end
end