class ErrorCodes
	@@errors = { 
		"Unknown error" => 0,
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
		"Expired Token" => 21,
		"Impossible longitude" => 22,
		"Impossible latitude" => 23,
		"Longitude can't be blank" => 24,
		"MatchID is invalid" => 25,
		"Permission denied" => 26,
		"User not founded" => 27,
		"Login or E-mail is required" => 28,
		"You are already a follower of this user" => 29,
		"You are not follower of this user" => 30,
		"You can't follow yourself" => 31,
		"You don't have permission to do this action" => 32,
		"Initials can't be blank" => 33,
		"Initials has already been taken" => 34,
		"Name has already been taken" => 35,
		"Limit must be less or equals then 20" => 36,
		"This member is not on the team" => 37,
		"Start date can't be blank" => 38,
		"End date can't be blank" => 39,
		"Latitude is invalid" => 40,
		"Longitude is invalid" => 41,
		"Latitude can't be blank" => 42,
		"Start date can't be in the past" => 43,
		"End date can't be in the past" => 44,
		"End date can't be before than start date" => 45,
		"End date must be at least one hour longer than start date" => 46,
		"Radius must be less or equals then 10" => 47,
		"You can't leave from a game that you don't participate" => 48,
		"You are already participating in this game" => 49,
		"The game was removed because didn't have more participants" => 50,
		"Title can't be blank" => 51,
		"This member is not on the team or not exist" => 52,
		"You don't have a pending invitation from this time" => 53,
		"This user is already a team member" => 54,
		"Phones must be a array of phones" => 55,
		"Phones is invalid. Phone format is: +5500111111111" => 56,
		"Rating must be between 0 and 5" => 57,
		"Society owner can't rating own society" => 58,
		"You already rated this society" => 59
	}

	@@errors_translation = {
		"Signature verification raised" => 20,
		"nil user" => 20,
		"revoked token" => 21,
		"You need to sign in or sign up before continuing." => 16
	}

	def self.get_error_by_message(error_message)
		if @@errors.key?(error_message)
			return {code: @@errors[error_message], message: error_message}
		elsif @@errors_translation.key?(error_message)
			code = @@errors_translation[error_message]
			return {code: code, message: ErrorCodes.get_error_message(code)}
		end
		# TODO: Remove it when map all errors from model validation
		puts "Not mapped error message: #{error_message}"
	end

	def self.get_errors_by_messages(error_messages)
		return error_messages.collect { |message| get_error_by_message(message) }
	end

	def self.get_error_message(error_code)
		return @@errors.key(error_code) unless @@errors.key(error_code).nil?
		return @@errors_translation.key(error_code) unless @@errors_translation.key(error_code).nil?
		# TODO: Remove it when map all errors from model validation
		puts "Not mapped error code: #{error_code}"
	end

	def self.get_error_messages(error_codes)
		return error_codes.collect { |code| ErrorCodes.get_error_message(code) }
	end
end