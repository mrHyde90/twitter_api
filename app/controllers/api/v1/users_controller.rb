class Api::V1::UsersController < ApplicationController
	include AuthorizeRequest
	before_action :set_user, only: [:show, :destroy, :update]
	before_action :correct_user, only: [:update]
	before_action :admin_user, only: [:destroy]

	def index
		users = User.all
		render json: users
	end

	def show
		render json: @user
	end

	def update
		if @user.update(user_params)
			render json: @user
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	def destroy
    @user.destroy
    render json: { message: 'Usuario eliminado' }, status: :ok
  end

	private 
		def user_params
			params.require(:user).permit(:name, :email, :lastname, :username, :password,
                                   :password_confirmation)
		end

		def set_user
			@user = User.find(params[:id])
			rescue ActiveRecord::RecordNotFound
				render json: { errors: ['Usuario no encontrado'] }, status: :not_found
		end

		def correct_user
			render json: { error: "No tienes permiso para actualizar este usuario" }, status: :forbidden unless @current_user.owns?(@user)
		end


		def admin_user
			render json: { error: "No tienes permisos de administrador" }, status: :forbidden unless @current_user.admin?
		end
end
