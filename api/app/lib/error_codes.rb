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
		"Birthday can't be in the past" => 12,
		"Gender is invalid" => 13,
		"Gender must be 'M', 'F', or 'O'" => 14,
		"Name can have only letters" => 15
	}

	def self.get_error_code(error_message)
		return {code: @@errors[error_message], message: error_message} if @@errors.key?(error_message)
		# FIXME: Remove when map all errors from model validation
		puts "Not mapped error message: #{error_message}"
	end

	def self.get_error_codes(error_messages)
		error_messages.collect { |message| ErrorCodes.get_error_code(message) }
	end
end