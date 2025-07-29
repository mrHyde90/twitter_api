class Api::V1::AuthenticationController < ApplicationController
	def login
		response = Services::AuthenticationService.login(login_params)

		render_success(response, :ok)
	end

	def signup
		response = Services::AuthenticationService.signup(user_params)

		render_success(response, :ok)
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :lastname, :username, :password,
                                   :password_confirmation)
		end

		def login_params
			params.require(:user).permit(:email, :password)
		end
end
