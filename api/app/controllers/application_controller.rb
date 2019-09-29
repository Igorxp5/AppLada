class ApplicationController < ActionController::API
	
	def format_response(args = {})
		unless args[:errors].nil?
			validate_response_errors(args[:errors])
		else
			args[:errors] = []
		end
		args[:errors] = ErrorCodes.get_error_codes(args[:errors])
		args[:payload] = {} if args[:payload].nil?
		return {data: args[:payload], errors: args[:errors]}
	end

	private

	def validate_response_errors(errors)
		raise_message = 'errors must be string list'
		raise ArgumentError, raise_message unless errors.respond_to? :select
		if not errors.empty? and (errors.select {|s| s.instance_of? String}).empty?
			raise ArgumentError, raise_message
		end
	end
end
