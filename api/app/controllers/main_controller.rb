class MainController < ApplicationController
	before_action :restrict_to_development
	before_action :authenticate_user!

	def index
		payload = {msg: 'You are logged in', current_user: current_user}
		render json: format_response(payload: payload), status: :ok
	end

end
