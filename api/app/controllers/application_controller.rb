class ApplicationController < ActionController::API
	include ActionController::MimeResponds

	respond_to :json

	def not_found
		render json: format_response(errors: 19)
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
end
