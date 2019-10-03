class ErrorCodes
	@@errors = { 
		"Password is too short (minimum is 8 characters)" => 1,
		"Password is too long (maximum is 16 characters)" => 2,
		"Email is invalid" => 3,
		"Login can't be blank" => 4,
		"Birthday can't be blank" => 5,
		"Email can't be blank" => 6,
		"Name can't be blank" => 7,
		"Password can't be blank" => 8,
		"Gender can't be blank" => 9,
		"Email has already been taken" => 10,
		"Login has already been taken" => 11,
		"Birthday can't be in the future" => 12,
		"Gender is invalid" => 13,
		"Gender must be 'M', 'F', or 'O'" => 14,
		"Name can have only letters" => 15,
		"Unauthorized access" => 16,
		"Invalid parameters" => 17,
		"Login or password incorrect" => 18,
		"Resource not found" => 19,
		"Empty or Invalid Token" => 20,
		"Expired Token" => 21
	}

	def self.get_error_by_message(error_message)
		return {code: @@errors[error_message], message: error_message} if @@errors.key?(error_message)
		# FIXME: Remove when map all errors from model validation
		puts "Not mapped error message: #{error_message}"
	end

	def self.get_errors_by_messages(error_messages)
		return error_messages.collect { |message| get_error_by_message(message) }
	end

	def self.get_error_message(error_code)
		return @@errors.key(error_code) unless @@errors.key(error_code).nil?
		# FIXME: Remove when map all errors from model validation
		puts "Not mapped error code: #{error_code}"
	end

	def self.get_error_messages(error_codes)
		return error_codes.collect { |code| ErrorCodes.get_error_message(code) }
	end
end