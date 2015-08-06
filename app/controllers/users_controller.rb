class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def downgrade
		@user = User.find(params[:id])

		@user.downgrade_to_standard_and_save

		redirect_to edit_user_registration_path
	end
end
