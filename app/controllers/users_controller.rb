class UsersController < ApplicationController

	include SessionsHelper

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "Welcome to Roominatr"
			sign_in(@user)
			render :show
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
		p params[:user][:password]
		params[:user].delete(:password) if params[:user][:password].blank?
		@user = User.find(params[:id]) 
		if @user.update_attributes(params[:user]) 
			flash[:success] = "Profile Updated!"
			redirect_to @user
		else
			flash[:error] = @user.errors.full_messages
			render :edit
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

	def destroy
		sign_out
		User.destroy(params[:id])
		redirect_to new_user_path
	end

end
