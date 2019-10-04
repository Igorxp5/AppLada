class ApplicationController < ActionController::API

	def not_found
		render json: format_response(errors: ErrorCodes.get_error_message(19))
	end
	
	def format_response(args = {})
		if not args[:errors].nil?
			validate_response_errors(args[:errors])
		else
			args[:errors] = []
		end
		
		args[:errors] = [args[:errors]] if args[:errors].instance_of? String
		args[:errors] = ErrorCodes.get_errors_by_messages(args[:errors])
		args[:payload] = {} if args[:payload].nil?
		return {data: args[:payload], errors: args[:errors]}
	end

	def authorize_request
		header = request.headers['Authorization']
		header = header.split(' ').last if header
		begin
			@decoded = JsonWebToken.decode(header)
			@current_user = User.find_by_login(@decoded[:login])
		rescue ActiveRecord::RecordNotFound => e
			unauthorized_request
		rescue JWT::ExpiredSignature => e
			unauthorized_request(21)
		rescue JWT::DecodeError => e
			unauthorized_request(20)
		end
	end

	def unauthorized_request(error_code=nil)
		if error_code.nil?
			render json: format_response(errors: ErrorCodes.get_error_message(16)), status: :unauthorized
		else
			render json: format_response(errors: ErrorCodes.get_error_message(error_code)), status: :unauthorized
		end
	end

	protected

	def restrict_to_development
		head(:not_found) unless Rails.env.development?
	end

	private

	def validate_response_errors(errors)
		raise_message = 'errors must be string or string list'
		unless errors.instance_of? String
			raise ArgumentError, raise_message unless errors.respond_to? :select
			if not errors.empty? and (errors.select {|s| s.instance_of? String}).empty?
				raise ArgumentError, raise_message
			end
		end
	end
end
