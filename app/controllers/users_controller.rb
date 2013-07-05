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
		paramz = params[:user]
		datestring = "#{paramz["birthday(1i)"]}-#{paramz["birthday(2i)"]}-#{paramz["birthday(3i)"]}"

		["birthday(1i)", "birthday(2i)", "birthday(3i)"].each do |birth|
			paramz.delete(birth) if paramz[birth]
		end

		paramz[:birthday] = Date.parse(datestring)

		p paramz

		@user = User.find(params[:id]) 
		if @user.update_attributes(paramz)
			flash[:success] = "Profile Updated!"
			redirect_to user_path(@user)
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
