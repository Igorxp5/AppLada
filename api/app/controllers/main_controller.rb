class MainController < ApplicationController
	before_action :restrict_to_development
	before_action :authorize_request

	def index
		render json: format_response(payload: 'You are logged in'), status: :ok
	end
end
