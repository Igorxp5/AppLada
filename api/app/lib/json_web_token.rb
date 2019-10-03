class JsonWebToken
	SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
	EXPIRATION_TIME = 24.hours.from_now

	def self.encode(payload, exp=EXPIRATION_TIME)
		payload[:exp] = exp.to_i
		JWT.encode(payload, SECRET_KEY)
	end

	def self.decode(token)
		decoded = JWT.decode(token, SECRET_KEY)[0]
		HashWithIndifferentAccess.new decoded
	end

	def self.EXPIRATION_TIME
		return EXPIRATION_TIME
	end
end