class ApplicationController < ActionController::API
	include ActionController::MimeResponds

	respond_to :json

	def not_found
		render json: format_response(errors: 19), status: :not_found
	end

	protected

	def format_response(args = {})
		DeviseFailureApp.format_response(args)
	end

	def unauthorized_request(error_code=nil)
		if error_code.nil?
			render json: format_response(errors: 16), status: :unauthorized
		else
			render json: format_response(errors: error_code), status: :unauthorized
		end
	end

	def forbidden_request(error_code=nil)
		if error_code.nil?
			render json: format_response(errors: 32), status: :forbidden
		else
			render json: format_response(errors: error_code), status: :forbidden
		end
	end

	def not_found_request(error_code=nil)
		if error_code.nil?
			render json: format_response(errors: 19), status: :not_found
		else
			render json: format_response(errors: error_code), status: :not_found
		end
	end

	def find_user
		user_login = params[:login].present? ? params[:login] : params[:user_login]
		@user = User.find_by_login!(user_login)
		rescue ActiveRecord::RecordNotFound
			render json: format_response(errors: 27), status: :not_found
	end

	def restrict_to_development
		head(:not_found) unless Rails.env.development?
	end

	def validate_conditions(conditions)
		errors = conditions.collect { |condition| ErrorCodes.get_error_message(condition[1]) unless condition[0] }
		errors = errors.uniq.compact
		unless errors.empty?
			render json: format_response(errors: errors), status: :bad_request
		end
	end

	def validate_limit
		if params[:limit].present?
			if not params[:limit] =~ /^\d+$/ or params[:limit].to_i > 20
				render json: format_response(errors: 36), status: :bad_request
			end
		else 
			params[:limit] = "20"
		end
	end
end
