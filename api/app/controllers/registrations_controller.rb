class RegistrationsController < Devise::RegistrationsController
	respond_to :json

	def create
		build_resource(register_params)
		
		resource.save
		if resource.persisted?		
			render json: format_response, status: :created
		else
			render json: format_response(errors: resource.errors.full_messages), status: :bad_request
		end
	end

	def register_params
		params.permit(
			:login, :password, :name, :email, :gender, :birthday
		)
  	end
end