class UsersController < ApplicationController

	include SessionsHelper
	include UsersHelper

	def index
		@users = User.all - [current_user]
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "Welcome to Roominatr"
			sign_in(@user)
			redirect_to user_path(current_user)
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		paramz = format_params(params[:user])

		if @user.update_attributes(paramz)
			flash[:success] = "Profile Updated!"
			redirect_to user_path(@user)
		else
			flash[:error] = @user.errors.full_messages
			if paramz[:password]
			 render :edit_user_password
			else
	 		 render :edit
			end
		end
	end

	def update_picture
		@user = User.find(params[:id])
		if @user.update_attribute(:avatar, params[:user][:avatar])
			flash[:success] = "Picture Updated!"
			redirect_to @user
		else
			flash[:error] = @user.errors.full_messages
			render :edit
		end
	end

	def edit_password
		@user = User.find(params[:id])
		render :edit_user_password
	end

	def destroy
		sign_out
		User.destroy(params[:id])
		redirect_to new_user_path
	end

	def search

	end

end
