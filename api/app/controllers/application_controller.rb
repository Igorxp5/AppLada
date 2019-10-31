class ApplicationController < ActionController::API
	include ActionController::MimeResponds

	respond_to :json

	def not_found
		render json: format_response(errors: ErrorCodes.get_error_message(19))
	end

	protected

	def format_response(args = {})
		DeviseFailureApp.format_response(args)
	end

	def unauthorized_request(error_code=nil)
		if error_code.nil?
			render json: format_response(errors: ErrorCodes.get_error_message(16)), status: :unauthorized
		else
			render json: format_response(errors: ErrorCodes.get_error_message(error_code)), status: :unauthorized
		end
	end

	def restrict_to_development
		head(:not_found) unless Rails.env.development?
	end
end
